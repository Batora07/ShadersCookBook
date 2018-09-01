using System.Collections;
using System.Collections.Generic;
using UnityEngine;

[ExecuteInEditMode]
public class SetRadiusProperties : MonoBehaviour {

    public bool isEnemy = false;
    public bool isEnabled = true;
    public Material radiusMaterial;
    public float radius = 1;
    public Color color = Color.white;
	
	void Update () {
	    if(radiusMaterial != null && isEnabled)
        {
            if (isEnemy)
            {
                color = Color.red;
            }
            else
            {
                color = Color.green;
            }
            radiusMaterial.SetVector("_Center", transform.position);
            radiusMaterial.SetFloat("_Radius", radius);
            radiusMaterial.SetColor("_RadiusColor", color);
        }	
	}
}
