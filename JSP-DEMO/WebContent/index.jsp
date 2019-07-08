<%@page import="java.sql.Connection"%>
<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.Driver"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.ResultSet"%>

<%
	Class.forName("com.mysql.cj.jdbc.Driver");
	Connection c = DriverManager.getConnection(
			"jdbc:mysql://localhost:3306/demo?useUnicode=true&useJDBCCompliantTimezoneShift=true&useLegacyDatetimeCode=false&serverTimezone=UTC",
			"root", "Mysql@123");
	Statement stmt = c.createStatement();
	String delete = request.getParameter("delButton");
	String update = request.getParameter("updtButton");
	String name = request.getParameter("name");
	String empId = request.getParameter("ID");

	int j = 0;
%>
<form action="index.jsp">
	Enter employee id : <input type="text" name="ID"> <br>
	Enter employee name : <input type="text" name="name"> <input
		type="submit"> <input type="reset"> <br> <br>
	<table border=1>
		<tr>
			<th>ID</th>
			<th>Name</th>
			<th>Delete</th>
			<th>Update</th>
		</tr>


		<%
			if (delete != null) {
				Statement stmt2 = c.createStatement();
				stmt2.execute("Delete FROM employee WHERE EmployeeId=" + Integer.parseInt(delete) + ";");

			} else if (update != null) {
				Statement stmt4 = c.createStatement();
				stmt4.execute("UPDATE employee set EmployeeName='" + name + "' WHERE EmployeeId="
						+ Integer.parseInt(update) + ";");
			} else if (empId != null && name != null) {
				Statement stmt3 = c.createStatement();
				stmt3.execute("INSERT IGNORE into employee values (" + Integer.valueOf(empId) + ",'" + name + "');");
			}
			ResultSet r = stmt.executeQuery("select * from employee");

			while (r.next()) {
		%>
		<tr>
			<td><%=r.getInt(1)%></td>
			<td><%=r.getString(2)%></td>
			<td><button type="submit" name="delButton"
					value="<%=r.getInt(1)%>">Delete</button></td>
			<td><button type="submit" name="updtButton"
					value="<%=r.getInt(1)%>">Update</button></td>

		</tr>

		<%
			j++;
			}
			c.close();
		%>
	</table>
</form>