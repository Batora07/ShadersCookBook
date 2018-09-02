using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class Dissolve : MonoBehaviour {

    public bool finished = false;
    public bool resetDissolve = false;
    public float speedDissolve = 0.1f;
    public Material mat;

    public void Start()
    {
        mat = GetComponent<MeshRenderer>().material;
    }

    public void Update()
    {
        if(mat != null && !finished)
        {
            SetDissolve();
        }
        else if(finished && resetDissolve)
        {
            ResetDissolve();
        }
    }

    private void SetDissolve()
    {
        float sliceAmount = mat.GetFloat("_SliceAmount");
        if (sliceAmount >= 1)
        {
            finished = true;
        }
        else
        {
            if(sliceAmount == 0)
            {
                sliceAmount = 0.1f;
            }
            sliceAmount += speedDissolve * Time.deltaTime;
            mat.SetFloat("_SliceAmount", sliceAmount);
        }
    }

    private void ResetDissolve()
    { 
        finished = false;
        mat.SetFloat("_SliceAmount", 0);
        resetDissolve = false;
    }
}
