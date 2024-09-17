using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class CategoryManager : MonoBehaviour
{
    [SerializeField] List<GameObject> categories;

    public void SetCategory(int categoryNum){
        foreach(GameObject category in categories){
            category.SetActive(false);
        }
        categories[categoryNum].SetActive(true);
    }
}
