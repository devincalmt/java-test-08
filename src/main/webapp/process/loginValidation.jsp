<%@ page contentType="text/html; charset=utf-8" language="java" import="java.sql.*" errorPage="" %>
<%@ page import="org.json.simple.JSONObject" %>
<%@ page import="java.io.IOException" %>
<%@ page import="java.io.InputStream" %>
<%@ page import="java.nio.charset.StandardCharsets" %>
<%@ page import="org.json.simple.parser.JSONParser" %>
<%@ page import="org.json.simple.JSONArray" %>
<%@ page import="org.json.simple.parser.ParseException" %>
<%!

    private JSONObject getUser(String userId, String password, HttpServletRequest request) throws IOException {
        InputStream inputStream = request.getServletContext().getClassLoader().getResourceAsStream("users.json");
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
%>
<%
    String userId = request.getParameter("userId");
    String password = request.getParameter("password");

    JSONObject user = getUser(userId, password, request);

    if(user != null) {
        session.setAttribute("test", "asd");
        session.setAttribute("user", user);
        response.sendRedirect("../home.jsp");
    } else {
        response.sendRedirect("../index.jsp");
    }
%>