using UnityEngine;

public class LightScript : MonoBehaviour
{
    Light light;
    public GameObject slender;
    int a, b=0,c=0;
    Renderer renderer;
    void Start()
    {
        light = GetComponent<Light>();
        renderer = slender.GetComponent<Renderer>();
        renderer.enabled = false;
    }

    void Update()
    {
        a = Random.Range(1, 100);
        if (b == 4)
        {
            b = 0;
            c++;
        }
        if (a < 4)
            b++;
        
        light.enabled = b<=2;
        renderer.enabled = c % 5 == 0;
    }
}
