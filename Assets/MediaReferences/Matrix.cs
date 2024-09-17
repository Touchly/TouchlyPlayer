
using UnityEngine;


[CreateAssetMenu(fileName = "Matrix", menuName = "ScriptableObjects/Matrix", order = 1)]
public class Matrix : ScriptableObject
{
    public Matrix4x4 leftEyeMatrix;
    public Matrix4x4 rightEyeMatrix;
}