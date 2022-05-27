<%@ page import="org.json.simple.JSONObject" %>
<%@ page import="java.io.InputStream" %>
<%@ page import="java.nio.charset.StandardCharsets" %>
<%@ page import="org.json.simple.parser.JSONParser" %>
<%@ page import="org.json.simple.JSONArray" %>
<%@ page import="java.io.IOException" %>
<%@ page import="org.json.simple.parser.ParseException" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="java.util.HashMap" %>
<%@ page import="java.util.Map" %>

<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%!
    JSONArray getJsonArray(HttpServletRequest request, String path) throws IOException, ParseException {
        InputStream inputStream = request.getServletContext().getClassLoader().getResourceAsStream(path);
        String text = new String(inputStream.readAllBytes(), StandardCharsets.UTF_8);

        JSONParser parser = new JSONParser();
        JSONArray jsonArray = (JSONArray) parser.parse(text);

        return jsonArray;
    }
%>
<%
    if(session.getAttribute("authenticated")==null)
    {
        response.sendRedirect(request.getContextPath());
        return;
    }

    JSONArray departments = getJsonArray(request, "departments.json");
    JSONArray users = getJsonArray(request, "students.json");

    HashMap<String, ArrayList<JSONObject>> listOfUsers = new HashMap<>();
    HashMap<String, Integer> passStudentByDepartments = new HashMap<>();

    for (int i=0;i<users.size();i++){
        String departmentId = (String) ((JSONObject)users.get(i)).get("departmentId");
        ArrayList<JSONObject> prevList = listOfUsers.getOrDefault(departmentId, new ArrayList<>());
        prevList.add((JSONObject) users.get(i));
        listOfUsers.put(departmentId, prevList);

        if((Integer)((Long)(((JSONObject) users.get(i)).get("mark"))).intValue() >= 40) passStudentByDepartments.put(departmentId, passStudentByDepartments.getOrDefault(departmentId, 0) + 1);
    }

%>
<html>
<head>
    <title>JSP - Home Page</title>
    <link rel="stylesheet" type="text/css" href="vendor/bootstrap/css/bootstrap.min.css">
    <link rel="stylesheet" type="text/css" href="fonts/font-awesome-4.7.0/css/font-awesome.min.css">
    <link rel="stylesheet" type="text/css" href="vendor/animate/animate.css">
    <link rel="stylesheet" type="text/css" href="vendor/css-hamburgers/hamburgers.min.css">
    <link rel="stylesheet" type="text/css" href="vendor/select2/select2.min.css">
    <link rel="stylesheet" href="css/util.css">
    <link rel="stylesheet" href="css/home.css">
</head>
<body>
    <%@include file = "header.jsp"%>
    <div class="limiter">
        <div class="container-table100">
            <div class="wrap-table100">
                <div class="table100">
                    <table class="main-table">
                        <thead>
                        <tr class="table100-head">
                            <th class="column1">Department</th>
                            <th class="column2">Student ID</th>
                            <th class="column3">Marks</th>
                            <th class="column4">Pass %</th>
                        </tr>
                        </thead>
                        <tbody>
                        <%for ( int i = 0; i < departments.size(); i++){ %>
                            <% String currDepartmentId = (String) ((JSONObject)departments.get(i)).get("departmentId"); %>
                            <% Integer totalUser = listOfUsers.get(currDepartmentId).size(); %>
                            <% for(int j=0;j<totalUser;j++) {%>
                                <% JSONObject user = (JSONObject) listOfUsers.get(currDepartmentId).get(j); %>
                                <tr>
                                    <td class="<%= j!=0 ? "hidden-td" : "" %>" rowspan="<%= totalUser %>"><%=((JSONObject)departments.get(i)).get("departmentId")%></td>
                                    <td>
                                        <label data-toggle="modal" data-target="<%= "#exampleModalCenter-"+i+"-"+j %>"><%= user.get("studentId") %></label>
                                        <div class="modal fade" id="<%= "exampleModalCenter-"+i+"-"+j %>" tabindex="-1" role="dialog" aria-labelledby="exampleModalCenterTitle" aria-hidden="true">
                                            <div class="modal-dialog modal-dialog-centered" role="document">
                                                <div class="modal-content">
                                                    <div class="modal-header">
                                                        <h5 class="modal-title" id="exampleModalLongTitle">Student Data</h5>
                                                        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                                                            <span aria-hidden="true">&times;</span>
                                                        </button>
                                                    </div>
                                                    <div class="modal-body">
                                                        <table>
                                                            <tr>
                                                                <td>Student ID</td>
                                                                <td>:</td>
                                                                <td><%= user.get("studentId") %></td>
                                                            </tr>
                                                            <tr>
                                                                <td>Student Name</td>
                                                                <td>:</td>
                                                                <td><%= user.get("studentName") %></td>
                                                            </tr>
                                                        </table>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                    </td>
                                    <td><%= user.get("mark") %></td>
                                    <td class="<%= j!=0 ? "hidden-td" : "" %>" rowspan="<%= totalUser %>"><%= passStudentByDepartments.getOrDefault(currDepartmentId, 0) * 100 / totalUser %></td>
                                </tr>
                            <%}%>
                        <%}%>
                        </tbody>
                    </table>
                </div>
            </div>
        </div>
    </div>

    <script src="vendor/jquery/jquery.js"></script>
    <script src="vendor/bootstrap/js/popper.js"></script>
    <script src="vendor/bootstrap/js/bootstrap.min.js"></script>
    <script src="vendor/select2/select2.min.js"></script>
    <script src="vendor/tilt/tilt.jquery.min.js"></script>
    <script src="vendor/jquery/jquery.js"></script>
</body>
</html>
