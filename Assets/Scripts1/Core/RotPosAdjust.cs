using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.Events;
using TMPro;

#if STEAM_VR
using Valve.VR;
#endif

public class RotPosAdjust : MonoBehaviour
{
    public Transform controllerL, controllerR, UI, reference, screen, visuals;
    private Vector3 initialPosL, initialPosR, initialReference, initialPosScreen, initialScaleScreen;
    private Quaternion initialRotationUI, initialRotation, initialRotScreen, initialRotChild;
    public GameObject title, markerRot, markerPos, mesh, player, screenFlat, PhysicsMesh, monoScreen;
    public CanvasGroup UIgroup;
    public UnityEvent OnStart, OnEnd;
    private float initialControllerDistance, initialControllerRoll;
    bool screenWasActive = false;
    [SerializeField] TextMeshProUGUI indicatorText;
    [SerializeField] CurrentVideo currentVideo;

    //Modes: Idle, Adjust Position, Adjust Rotation
    private enum State {
        Idle,
        adjustingRot,
        adjustingPos
    }

    private State state = State.Idle;

    void Start()
    {
        title.SetActive(false);
        UIgroup.alpha = 1f;
    }

    public static Vector3 getRelativePosition(Vector3 position, Transform origin)
    {
        Vector3 distance = position - origin.position;
        Vector3 relativePosition = Vector3.zero;
        relativePosition.x = Vector3.Dot(distance, origin.right.normalized);
        relativePosition.y = Vector3.Dot(distance, origin.up.normalized);
        relativePosition.z = Vector3.Dot(distance, origin.forward.normalized);

        return relativePosition;
    }

    float getRotationFromPoints(Vector3 point1, Vector3 point2)
    {
        Vector3 line = getRelativePosition(point1, screen) - getRelativePosition(point2, screen);
        float angle = Mathf.Atan2(line.y, line.x) * Mathf.Rad2Deg;
        return angle;
    }

    //Set current state (adjusting rotation or position)
    public void SetState(int mode)
    {
        //If request the same state as before, go back to Idle. Else go to the requested state. mode=0 -> rotation /  mode=1 -> position
        if ((state == State.adjustingRot && mode == 0) || (state == State.adjustingPos && mode == 1))
        {
            
            state = State.Idle;
            title.SetActive(false);
            markerRot.SetActive(false);
            if (markerPos) { markerPos.SetActive(false); }
        } else
        {
            title.SetActive(true);
            if (mode == 0)
            {

                state = State.adjustingRot;
                markerRot.SetActive(true);
                indicatorText.SetText("Grab with your right hand for pitch/yaw\nGrab with both hands for roll");
                if (markerPos) { markerPos.SetActive(false); }
            }
            else if (mode == 1)
            {

                
                state = State.adjustingPos;
                markerRot.SetActive(false);
                indicatorText.SetText("Grab with your right hand to move\nGrab with both hands to scale");
                if (markerPos) { markerPos.SetActive(true); }
            }
        }
    }

    void Update()
    {
        if (state != State.Idle)
        {
            #if !STEAM_VR
            bool leftPressedThisFrame = OVRInput.GetDown(OVRInput.RawButton.LHandTrigger);
            bool rightPressedThisFrame = OVRInput.GetDown(OVRInput.RawButton.RHandTrigger) || (OVRInput.IsControllerConnected(OVRInput.Controller.Hands) && OVRInput.GetDown(OVRInput.RawButton.A));
            bool rightReleasedThisFrame = OVRInput.GetUp(OVRInput.RawButton.RHandTrigger) || (OVRInput.IsControllerConnected(OVRInput.Controller.Hands) && OVRInput.GetUp(OVRInput.RawButton.A));

            bool leftPressed = OVRInput.Get(OVRInput.RawButton.LHandTrigger);
            bool rightPressed  = OVRInput.Get(OVRInput.RawButton.RHandTrigger) || (OVRInput.IsControllerConnected(OVRInput.Controller.Hands) && OVRInput.Get(OVRInput.RawButton.A));
            #else

            bool leftPressedThisFrame = SteamVR_Input.GetStateDown("GrabGrip", SteamVR_Input_Sources.LeftHand);
            bool rightPressedThisFrame = SteamVR_Input.GetStateDown("GrabGrip", SteamVR_Input_Sources.RightHand);
            bool rightReleasedThisFrame = SteamVR_Input.GetStateUp("GrabGrip", SteamVR_Input_Sources.RightHand);

            bool leftPressed = SteamVR_Input.GetState("GrabGrip", SteamVR_Input_Sources.LeftHand);
            bool rightPressed = SteamVR_Input.GetState("GrabGrip", SteamVR_Input_Sources.RightHand);
            #endif

            //If while pressing right, left is pressed or while pressing left, right is pressed
            if ((leftPressedThisFrame && rightPressed) || (rightPressedThisFrame && leftPressed)){
                initialControllerDistance = Vector3.Distance(controllerL.position, controllerR.position);
                initialScaleScreen = screen.localScale;

                initialControllerRoll = getRotationFromPoints(controllerL.position, controllerR.position);

                initialRotChild = visuals.rotation;
            }

            //First pressed grab button. Save current position/rotation
            if (rightPressedThisFrame)
            {
                if (monoScreen){
                    monoScreen.SetActive(false);
                }
                if (screenFlat){
                    screenWasActive = screenFlat.activeSelf;
                } else {
                    screenWasActive = false;
                }
                
                OnStart.Invoke();
                //Initial position/rotation of:
                //Hands
                initialPosR = controllerR.position;
                //Center eye
                initialReference = reference.position;

                //Screen
                initialPosScreen = visuals.position;
                initialRotScreen = screen.rotation;

                //Hide player for visibility while rotating/moving
                title.SetActive(false);
                if (mesh) { mesh.SetActive(true);}
                UIgroup.alpha=0f;
                if (screenFlat && screenWasActive) { screenFlat.SetActive(false); }
                if (PhysicsMesh){ PhysicsMesh.SetActive(false);}
            }
            
            //While pressed, update rotation/position-scale
            if (rightPressed)
            {
                if (state == State.adjustingRot)
                {
                    

                    if (leftPressed){
                        //Rotation mode, both hands pressed
                        Quaternion rotateZ = Quaternion.AngleAxis(getRotationFromPoints(controllerL.position, controllerR.position) - initialControllerRoll, Vector3.forward);
                        visuals.rotation = initialRotChild * rotateZ;

                    } else {
                         //Points as if they were always facing fowards
                        Vector3 initialPosRNorm = Quaternion.Inverse(reference.rotation) * initialPosR;
                        Vector3 currentPosRNorm = Quaternion.Inverse(reference.rotation) * controllerR.position;

                        //Rotation proportional to the movement difference
                        Vector2 rotationAngles = new Vector2(currentPosRNorm.x - initialPosRNorm.x, initialPosRNorm.y - currentPosRNorm.y);

                        //Define Rotation around pivot
                        Quaternion rotate = Quaternion.AngleAxis(rotationAngles[0] * 100, Vector3.up) * Quaternion.AngleAxis(rotationAngles[1] * 100, Vector3.right);
                        //Apply to screen
                        Quaternion newRotScreen = initialRotScreen * rotate;
                        screen.rotation = newRotScreen;
                        

                        //Pivot position
                        if (markerPos)
                        {
                            if (markerPos.activeSelf)
                            {
                                screen.position = rotate * (initialPosScreen - initialReference) + initialReference;
                            }
                        }
                    }

                    
                }

                else if (state == State.adjustingPos)
                {
                    //Scale mode, both hands pressed
                    if (leftPressed){
                        //Scale proportional to the distance difference
                        float scale = Vector3.Distance(controllerL.position, controllerR.position) / initialControllerDistance;

                        //Vector3 pivotToPosition = screen.position - controllerR.position;
                        //screen.position = controllerR.position + pivotToPosition * scale;
                        Vector3 newScale = new Vector3(initialScaleScreen.x*scale, initialScaleScreen.y*scale, initialScaleScreen.z*scale);
                        screen.localScale = newScale;
                    }

                    Vector3 move = (controllerR.position - initialPosR);
                    visuals.position = initialPosScreen + move;
                }
            }
            
            //Released
            if (rightReleasedThisFrame)
            {   
                bool is180 = true;
                if (currentVideo != null){
                    is180 = currentVideo.format != 1;
                }
                
                if (monoScreen && is180){
                    monoScreen.SetActive(true);
                }
                //Show player again. If we're still on menu.
                OnEnd.Invoke();
                if (player.activeSelf)
                {
                    UIgroup.alpha = 1f;
                    if (mesh) { mesh.SetActive(false); }
                    title.SetActive(true);
                }

                
                if (screenFlat && screenWasActive) { screenFlat.SetActive(true); }
                if (PhysicsMesh) {PhysicsMesh.SetActive(true);}
            }

        }
    }
}