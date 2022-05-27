package com.example.test;

import org.json.simple.JSONArray;
import org.json.simple.JSONObject;
import org.json.simple.parser.JSONParser;
import org.json.simple.parser.ParseException;

import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.*;
import java.nio.charset.StandardCharsets;

@WebServlet(name = "login-validation", value = "/login-validation")
public class LoginValidationServlet extends HttpServlet {

    private JSONObject getUser(String userId, String password) throws IOException {
        InputStream inputStream = this.getClass().getClassLoader().getResourceAsStream("users.json");
        String text = new String(inputStream.readAllBytes(), StandardCharsets.UTF_8);

        JSONParser parser = new JSONParser();
        try {
            JSONArray jsonArray = (JSONArray) parser.parse(text);
            for (int i=0;i<jsonArray.size();i++){
                JSONObject jsonObject = (JSONObject) jsonArray.get(i);
                if(jsonObject.get("userId").equals(userId) && jsonObject.get("password").equals(password)) return jsonObject;
            }
        } catch (ParseException e) {
            return null;
        }

        return null;
    }

    public void doPost(HttpServletRequest request, HttpServletResponse response) throws IOException {
        String userId = request.getParameter("userId");
        String password = request.getParameter("password");

        JSONObject user = getUser(userId, password);
        HttpSession session = request.getSession();

        if(user != null) {
            session.setAttribute("user", user);
            session.setAttribute("authenticated", true);
            response.sendRedirect(request.getContextPath()+"/home");
        } else {
            session.setAttribute("userId", userId);
            response.sendRedirect(request.getContextPath()+"?invalid=true");
        }

    }
}
