using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using OVR;

namespace Autohand.Demo{
    public class OVRHandControllerLinkFluid : HandControllerLink {
        public OVRInput.Controller controller;
        public OVRInput.Axis1D grabAxis;
        public OVRInput.Button grabButton;
        public OVRInput.Button squeezeButton;
        [Range(0, 320), HideInInspector]
        public int frequency = 50;
        
        bool grabbing = false;
        bool squeezing = false;

        List<HapticEvent> hapticEvents = new List<HapticEvent>();

        private void Start() {
            if(hand.left)
                handLeft = this;
            else
                handRight = this;
        }

        private IEnumerator FluidGrab(int cycles)
        {
            while (true)
            {
                hand.Grab();
                int i = 0;
                while (i < cycles)
                {
                    i += 1;
                    yield return new WaitForEndOfFrame();
                }
                hand.Release();
                yield return new WaitForEndOfFrame();

                if (grabbing == false)
                {
                    yield break;
                }
            }
        }

        public void Update() {
            if (!grabbing && OVRInput.GetDown(grabButton, controller)) {
                grabbing = true;
                StartCoroutine(FluidGrab(10));
            }

            if(grabbing && OVRInput.GetUp(grabButton, controller)) {
                grabbing = false;
                StopCoroutine("FluidGrab");
                hand.Release();
            }

            if(!squeezing && OVRInput.GetDown(squeezeButton, controller)) {
                squeezing = true;
                hand.Squeeze();
            }
            if(squeezing && OVRInput.GetUp(squeezeButton, controller)) {
                squeezing = false;
                hand.Unsqueeze();
            }

            hand.SetGrip(OVRInput.Get(grabAxis, controller));
        }

        public float GetAxis(OVRInput.Axis1D axis) {
            return OVRInput.Get(axis, controller);
        }

        public Vector2 GetAxis2D(OVRInput.Axis2D axis) {
            return OVRInput.Get(axis, controller);
        }
        
        public bool ButtonPressed(OVRInput.Button button) {
            return OVRInput.Get(button, controller);
        }
        
        public bool ButtonPressed(OVRInput.Touch button) {
            return OVRInput.Get(button, controller);
        }
        
        public bool ButtonTouched(OVRInput.Touch button) {
            return OVRInput.Get(button, controller);
        }

        public class HapticEvent {
            float dur;
            public float currDur;
            public float amp;
            public float freq;

            public HapticEvent(float duration, float amp, float freq) {
                currDur = duration;
                dur = duration;
                this.amp = amp;
                this.freq = freq;
            }

            public void ReduceDuration(float amount) { currDur = currDur - amount; }
            public float TotalDuration() { return dur; }
        }


        private void FixedUpdate() {
            for(int i = 0; i < hapticEvents.Count; i++) {
                if(hapticEvents[i].currDur > 0) {
                    hapticEvents[i].ReduceDuration(Time.fixedDeltaTime);
                    if(hapticEvents[i].currDur < 0)
                        hapticEvents[i].currDur = 0;
                    OVRInput.SetControllerVibration(hapticEvents[i].freq, hapticEvents[i].amp * (1f - (hapticEvents[i].currDur / hapticEvents[i].TotalDuration())), controller);
                }
            }

            for(int i = 0; i < hapticEvents.Count; i++) {
                if(hapticEvents[i].currDur <= 0) {
                    hapticEvents.RemoveAt(i);
                    OVRInput.SetControllerVibration(0, 0, controller);
                }
            }
        }

        public override void TryHapticImpulse(float duration, float amp, float frequency = 10) {
            hapticEvents.Add(new HapticEvent(duration, amp, frequency));
        }
    }
}
