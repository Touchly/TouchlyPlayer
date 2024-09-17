using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.Events;

public class UpdateSelector : MonoBehaviour
{
    public UnityEvent updateSelectors;
    // Start is called before the first frame update
    public void UpdateSelectors()
    {
        updateSelectors.Invoke();
    }
}
