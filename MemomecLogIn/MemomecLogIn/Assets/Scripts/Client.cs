using System.Collections;
using System;
using UnityEngine;
using UnityEngine.Networking;
using SimpleJSON;


public class Client : MonoBehaviour
{
    private const string _uri = "http://localhost:8000/"; //
    private const string _uriDur = "http://localhost:8000/dur";
    private LoginManager _loginMng;
    private int _currentRecordID=0;

    // Start is called before the first frame update
    void Start()
    {
        _loginMng = GetComponent<LoginManager>();

    }

   JSONNode ProcessServerResponse (string rawResponse){ 

        JSONNode node = JSON.Parse(rawResponse);

        return node;
    }  

    public IEnumerator SendRequest(string username, string password) 
    {
        WWWForm form = new WWWForm();
        form.AddField("Username", username);
        form.AddField("Password", password);
        form.AddField("Date", DateTime.Now.ToString());
        

        UnityWebRequest req = UnityWebRequest.Post(_uri, form);
        yield return req.SendWebRequest();

        if (req.result != UnityWebRequest.Result.Success)
        {
            Debug.LogError("Error while sending request!");              
        }
        else
        {
            JSONNode res = ProcessServerResponse(req.downloadHandler.text);
            _currentRecordID = res["insertId"]; // we save the last added loginrecord id so that we can change it after user logout.
            _loginMng.CloseLogin(username);
            _loginMng.LoginTime = DateTime.Now.TimeOfDay;

        }
    }

    public IEnumerator SendDuration(string duration)
    {
        WWWForm form = new WWWForm();
        form.AddField("RecordID", _currentRecordID);
        form.AddField("Duration", duration);

        UnityWebRequest req = UnityWebRequest.Post(_uriDur, form);
        yield return req.SendWebRequest();

        if (req.result != UnityWebRequest.Result.Success)
        {
            Debug.LogError("Error while sending duration request!");
        }
        else
        {
            Debug.Log("Duration is sended!");

        }

    }
}
