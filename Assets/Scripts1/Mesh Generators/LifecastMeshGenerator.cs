/*
The MIT License

Copyright © 2022 Lifecast Incorporated

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in
all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
THE SOFTWARE.
*/

using System.Collections;
using System.Collections.Generic;
using UnityEngine;

[RequireComponent(typeof(MeshFilter), typeof(MeshRenderer))]
public class LifecastMeshGenerator : MonoBehaviour
{
    // This affects the number of triangles in the generated mesh. It doesn't have to be 1 quad per
    // pixel to product reasonable results. Increasing this will improve visual quality and reduce
    // frame rate.
    public int GRID_SIZE = 1024;

    // This must match the "F-Theta Scale" parameter in the Lifecast VR180 to 6DOF converter application,
    // or the result will be warped. The default is 1.2, which corresponds to a little less FOV than 180 degrees,
    // and a little bit higher pixel density. FTHETA_SCALE = 1.0 corresponds to 180 degrees FOV.
    public float FTHETA_SCALE = 1.2f; 

    void Start()
    {  
      var vert_list = new List<Vector3>();
      var uv_list = new List<Vector2>();
      var triangle_list = new List<int>();

      for (int j = 0; j <= GRID_SIZE; ++j) {
        for (int i = 0; i <= GRID_SIZE; ++i) {
          float u = (float)i / (float)GRID_SIZE;
          float v = (float)j / (float)GRID_SIZE;
          float a = 2.0f * (u - 0.5f);
          float b = 2.0f * (v - 0.5f);
          float theta = Mathf.Atan2(b, a);
          
          float r = Mathf.Sqrt(a*a + b*b) / FTHETA_SCALE; 
          float phi = r * Mathf.PI / 2.0f;
          
          float x = Mathf.Cos(theta) * Mathf.Sin(phi);
          float y = Mathf.Sin(theta) * Mathf.Sin(phi);
          float z = Mathf.Cos(phi);

          vert_list.Add(new Vector3(x, y, z));
          uv_list.Add(new Vector2(u, v));
        }
      }

      for (int j = 0; j < GRID_SIZE; ++j) {
        for (int i = 0; i < GRID_SIZE; ++i) {
          int di = i - GRID_SIZE / 2;
          int dj = j - GRID_SIZE / 2;
          if (di * di + dj * dj > GRID_SIZE * GRID_SIZE  / 4) continue;

          int a = i + (GRID_SIZE + 1) * j;
          int b = a + 1;
          int c = a + (GRID_SIZE + 1);
          int d = c + 1;
  
          triangle_list.Add(a);
          triangle_list.Add(c);
          triangle_list.Add(b);

          triangle_list.Add(c);
          triangle_list.Add(d);
          triangle_list.Add(b);
        }
      }
    
      var mesh = new Mesh { name = "Lifecast Mesh" };   
      // We need this because we will have more than 65,535 vertices.
      mesh.indexFormat = UnityEngine.Rendering.IndexFormat.UInt32; 
      mesh.vertices = vert_list.ToArray();
      mesh.uv = uv_list.ToArray();
      mesh.triangles = triangle_list.ToArray();
  
      GetComponent<MeshFilter>().mesh = mesh;
    }
}
