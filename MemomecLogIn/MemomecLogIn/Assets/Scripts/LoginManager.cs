using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using TMPro;
using UnityEngine.UI;
using System;

public class LoginManager : MonoBehaviour
{
    [SerializeField] private TMP_InputField _usernameInput;
    [SerializeField] private TMP_InputField _passwordInput;
    [SerializeField] private Button _loginButton;
    [SerializeField] private GameObject _loginPanel;

    [SerializeField] private Button _logoutButton;
    [SerializeField] private GameObject _logoutPanel;
    [SerializeField] private TMP_Text _username;


    public TimeSpan LoginDuration;
    public TimeSpan LoginTime;

    private Client _client;
    // Start is called before the first frame update
    void Start()
    {
        _client = GetComponent<Client>();
        _loginButton.onClick.AddListener(LoginClicked);
        _logoutButton.onClick.AddListener(LogOut);
    }



    private void LoginClicked()
    {
        if(_usernameInput.text == "" || _passwordInput.text == "") // Check if inputfields are empty.
        {
            Debug.LogError("Enter login info!");
            return;
        }
        StartCoroutine(_client.SendRequest(_usernameInput.text, _passwordInput.text)); // we send login datas to server.
    }

    public void CloseLogin(string username)
    {
        _loginPanel.SetActive(false);
        _usernameInput.text = "";
        _passwordInput.text = "";
        _logoutPanel.SetActive(true);
        _username.text = username;
        
    }
    
    public void LogOut()
    {
        LoginDuration = DateTime.Now.TimeOfDay - LoginTime;
        StartCoroutine(_client.SendDuration(LoginDuration.ToString())); // we send login duration to server.
        _logoutPanel.SetActive(false);
        _loginPanel.SetActive(true);
        
    }
}
