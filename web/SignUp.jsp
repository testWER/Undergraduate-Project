<%-- 
    Document   : Template 2 column
    Created on : Dec 18, 2011, 12:11:32 PM
    Author     : Reshad
--%>

<% session.setAttribute("URL", request.getRequestURL()); %>
<%@page import="com.catalog.model.Checksum"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="com.catalog.model.MySQL"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>

<html>
    <head>
        <%
            if(session.getAttribute("Loggedin") != null ? (session.getAttribute("Loggedin").equals("true") ? true : false) : false)
            {
                out.println("<meta http-equiv=\"refresh\" content=\"5; url=index.jsp\">");
            }
        %>
        <title>
            TechE
        </title>
        <!-- Style Sheet Import Starts Here -->
        <link rel="stylesheet" type="text/css" href="Styles/styles.css" />
        <link rel="stylesheet" type="text/css" href="Styles/Menu/ddsmoothmenu.css" />
        <!-- Style Sheet Import Ends Here -->

        <!-- Script Import Starts Here -->
        <script type="text/javascript" src="Scripts/Validation/Validate.js"></script>
        <script type="text/javascript" src="Scripts/jQuery/jquery-1.6.2.js">
        </script>
        <script type="text/javascript" src="Scripts/Menu/ddsmoothmenu.js">
/***********************************************
* Smooth Navigational Menu- (c) Dynamic Drive DHTML code library (www.dynamicdrive.com)
* This notice MUST stay intact for legal use
* Visit Dynamic Drive at http://www.dynamicdrive.com/ for full source code
***********************************************/
        </script>
        <!-- Script Import Ends Here -->

        <!-- Script Declaration Starts Here -->
        <script type="text/javascript">
ddsmoothmenu.init(
{
mainmenuid: "smoothmenu-ajax",
customtheme: ["#025091", "#007ce7"],//customtheme: ["#1c5a80", "#18374a"], //override default menu CSS background values? Uncomment: ["normal_background", "hover_background"]
contentsource: ["smoothcontainer", "Scripts/Menu/menu.html"] //"markup" or ["container_id", "path_to_menu_file"]
})
        </script>
        
        <script>
            var uname=true;
            function setUname()
            {
                uname = false;
            }
            function validateForm()
            {
                
                if(!validateFirstName())
                {
                    return false;
                }
                else if(!validateLastName())
                {
                    return false;
                }
                else if(!uname)
                {
                    return false;
                }
                else if(!validatePassword())
                {
                    return false;
                }
                else if(!validateReEnterPassword())
                {
                    return false;
                }
                else if(!validateEmail())
                {
                    return false;
                }
                return true;
                    
            }
            function validateFirstName()
            {
                document.getElementById('err-FirstName').innerHTML = "";
                if(isEmpty('SignUpForm', 'txtFirstName'))
                {
                    document.getElementById('err-FirstName').innerHTML = "First name cannot be blank";
                    return false;
                }
                else if(minLength(2,'SignUpForm', 'txtFirstName'))
                {
                    document.getElementById('err-FirstName').innerHTML = "First name must be at least 2 characters long";
                    return false;
                }
                else if(!isOnlyChars('SignUpForm', 'txtFirstName'))
                {
                    document.getElementById('err-FirstName').innerHTML = "First name must contain only characters";
                    return false;
                }
                return true;
            }
            function validateLastName()
            {
                document.getElementById('err-LastName').innerHTML = "";
                if(isEmpty('SignUpForm', 'txtLastName'))
                {
                    document.getElementById('err-LastName').innerHTML = "Last name cannot be blank";
                    return false;
                }
                else if(minLength(2,'SignUpForm', 'txtLastName'))
                {
                    document.getElementById('err-LastName').innerHTML = "Last name must be at least 2 characters long";
                    return false;
                }
                else if(!isOnlyChars('SignUpForm', 'txtLastName'))
                {
                    document.getElementById('err-LastName').innerHTML = "Last name must contain only characters";
                    return false;
                }
                return true;
            }
            function validateUserName()
            {
                uname = true;
                document.getElementById('err-UserName').innerHTML = "";
                if(isEmpty('SignUpForm', 'txtUserName'))
                {
                    document.getElementById('err-UserName').innerHTML = "User name cannot be blank";
                    setUname();
                    return false;
                }
                else if(minLength(4,'SignUpForm', 'txtUserName'))
                {
                    document.getElementById('err-UserName').innerHTML = "User name must be at least 4 characters long";
                    setUname();
                    return false;
                }
                else if(!isValidUserName('SignUpForm', 'txtUserName'))
                {
                    document.getElementById('err-UserName').innerHTML = "User name must contain only alphabets, digits, underscore  character (_) or dot (.)";
                    setUname();
                    return false;
                }
                
                var XMLHttpRequestObject = false;
                if (window.XMLHttpRequest)
                {
                    XMLHttpRequestObject = new XMLHttpRequest();
                } else if (window.ActiveXObject) 
                {
                    XMLHttpRequestObject = new ActiveXObject("Microsoft.XMLHTTP");
                }
                if(XMLHttpRequestObject) 
                {
                    
                    XMLHttpRequestObject.open("POST", "Validation/CheckUserName");
                    XMLHttpRequestObject.setRequestHeader('Content-Type', 'application/x-www-form-urlencoded'); 
                    XMLHttpRequestObject.onreadystatechange = function() 
                    {
                        if (XMLHttpRequestObject.readyState == 4 && XMLHttpRequestObject.status == 200) 
                        {
                            if(parseInt(XMLHttpRequestObject.responseText,10) == 1)
                            {
                                document.getElementById('err-UserName').innerHTML = "User name already used";
                                false;
                                setUname();
                            }
                            delete XMLHttpRequestObject;
                            XMLHttpRequestObject = null;
                        }
                    }
                    XMLHttpRequestObject.send("UserName="+document.forms['SignUpForm'].elements['txtUserName'].value); 
                    return ret;
                }
                
            }
            function validatePassword()
            {
                document.getElementById('err-Password').innerHTML = "";
                if(isEmpty('SignUpForm', 'pwdPassword'))
                {
                    document.getElementById('err-Password').innerHTML = "Password cannot be blank";
                    setUname();
                    return false;
                }
                else if(minLength(6,'SignUpForm', 'pwdPassword'))
                {
                    document.getElementById('err-Password').innerHTML = "Password must be at least 6 characters long";
                    return false;
                }
                else if(containsSpace('SignUpForm', 'pwdPassword'))
                {
                    document.getElementById('err-Password').innerHTML = "Password cannot contain a space";
                    setUname();
                    return false;
                }
                return true;
            }
            function validateReEnterPassword()
            {
                document.getElementById('err-ReEnterPassword').innerHTML = "";
                if(isEmpty('SignUpForm', 'pwdReEnterPassword'))
                {
                    document.getElementById('err-ReEnterPassword').innerHTML = "Re-enter password cannot be blank";
                    return false;
                }
                if(!isEqualTo('SignUpForm', 'pwdReEnterPassword', 'pwdPassword'))
                {
                    document.getElementById('err-ReEnterPassword').innerHTML = "Re-enter password must match password";
                    return false;
                }
                return true;
            }
            function validateEmail()
            {
                document.getElementById('err-Email').innerHTML = "";
                if(isEmpty('SignUpForm', 'txtEmail'))
                {
                    document.getElementById('err-Email').innerHTML = "Email cannot be blank";
                    return false;
                }
                else if(!isEmail('SignUpForm', 'txtEmail'))
                {
                    document.getElementById('err-Email').innerHTML = "Not a valid email id";
                    return false;
                }
                return true;
            }
        </script>
        <!-- Script Declaration Ends Here -->


    </head>
    <body>

        <div id="wrap">
	
            <!-- Header code starts here -->
            <div id="header">

                <!-- Logo code starts here -->
                <div id="Logo">
                    <a href="index.jsp">
                    <img src="Images/Logos/TechE Logo.png" height="100" />
                    </a>
                </div>
		<!-- Logo code ends here -->
                
                <!-- Login code starts here -->
		<div id="Login">
                    <jsp:include page="hidden/Login.jsp"></jsp:include>
                </div>
                <!-- Login code ends here -->
	
            </div>
            <!-- Header code ends here -->
	
            <!-- Navigation menu code starts here -->
            <div id="nav" >
                <div id="smoothcontainer">
                    <noscript>
                    <a href="smoothmenu.html">Site map</a>
                    </noscript>
                </div>
            </div>
            <!-- Navigation menu code ends here -->
        
	
            <!-- center colum starts here -->
            <div id="center">
                <h1>
                    Sign Up
                </h1>
                <%
                    if(session.getAttribute("Loggedin") != null ? (session.getAttribute("Loggedin").equals("true") ? true : false) : false)
                    {
                        out.println("<p align=\"center\">You are already logged in Redirecting you to the home page</p>");
                    }
                    else if(request.getParameter("txtUserName") != null ? (request.getParameter("txtUserName")!=""? true:false) : false)
                    {
                        MySQL db= new MySQL();
                        Checksum checksum = new Checksum();
                        db.connect();
                        ResultSet rs;
                        rs = db.executeQuery("select max(UserID) from `user`;");
                        rs.next();
                        long userID = Long.parseLong(rs.getString(1));
                        db.executeUpdate("INSERT INTO `catalog`.`user` (`UserID`, `UserName`, `Password`, `Type`) VALUES ('" + ++userID + "', '" + request.getParameter("txtUserName") + "', '" + checksum.getSum(request.getParameter("pwdPassword")) + "', 1)");
                        rs=db.executeQuery("SELECT MAX(UserDetailID) FROM userdetails WHERE UserID='" + userID + "'");
                        rs.next();
                        short userDetailID;
                        try
                        {
                            userDetailID = Short.parseShort(rs.getString(1));
                        }
                        catch(NumberFormatException e)
                        {
                            userDetailID = 0;
                        }
                        db.executeUpdate("INSERT INTO `catalog`.userdetails (`UserID`, `UserDetailID`, `Detail`, `Value`) VALUES ('" + userID + "', '" + ++userDetailID +"', 'First Name','" + request.getParameter("txtFirstName") + "')");
                        db.executeUpdate("INSERT INTO `catalog`.userdetails (`UserID`, `UserDetailID`, `Detail`, `Value`) VALUES ('" + userID + "', '" + ++userDetailID +"', 'Last Name','" + request.getParameter("txtLastName") + "')");
                        db.executeUpdate("INSERT INTO `catalog`.userdetails (`UserID`, `UserDetailID`, `Detail`, `Value`) VALUES ('" + userID + "', '" + ++userDetailID +"', 'Email','" + request.getParameter("txtEmail") + "')");
                        
                        out.println("<p align=\"center\">You have signed up successfully,<br /> Please login above or continue surfing as an unregistered user</p>");
                        out.flush();
                    }
                    else
                    {
                %>
                <form action="SignUp.jsp" id="SignUpForm" method="post" onsubmit="return validateForm()" >
                    <table align="center">
                        <tr>
                            <td>
                                First name:
                            </td>
                            <td>
                                <input type="text" name="txtFirstName" onblur="return validateFirstName()"/>
                            </td>
                        </tr>
                        <tr>
                            <td id="err-FirstName" colspan="2" class="Error">
                            </td>
                        </tr>
                        <tr>
                            <td>
                                Last name:
                            </td>
                            <td>
                                <input type="text" name="txtLastName" onblur="return validateLastName()"/>
                            </td>
                        </tr>
                        <tr>
                            <td id="err-LastName" colspan="2" class="Error">
                            </td>
                        </tr>
                        <tr>
                            <td>
                                User name:
                            </td>
                            <td>
                                <input type="text" name="txtUserName" onblur="return validateUserName()"/>
                            </td>
                        </tr>
                        <tr>
                            <td id="err-UserName" colspan="2" class="Error">
                            </td>
                        </tr>
                        <tr>
                            <td>
                                Password:
                            </td>
                            <td>
                                <input type="password" name="pwdPassword" onblur="return validatePassword()" />
                            </td>
                        </tr>
                        <tr>
                            <td id="err-Password" colspan="2" class="Error">
                            </td>
                        </tr>
                        <tr>
                            <td>
                                Re-enter password:
                            </td>
                            <td>
                                <input type="password" name="pwdReEnterPassword" onblur="return validateReEnterPassword()" />
                            </td>
                        </tr>
                        <tr>
                            <td id="err-ReEnterPassword" colspan="2" class="Error">
                            </td>
                        </tr>
                        <tr>
                            <td>
                                Email id:
                            </td>
                            <td>
                                <input type="text" name="txtEmail" onblur="return validateEmail()"/>
                            </td>
                        </tr>
                        <tr>
                            <td id="err-Email" colspan="2" class="Error">
                            </td>
                        </tr>
                        <tr>
                            <td>
                            </td>
                            <td>
                                <input type="submit" value="SignUp" style="width:70px; height:30px" />
                            </td>
                        </tr>
                    </table>
                </form>
                <%
                    }
                %>
            </div>
            <!-- center colum ends here -->
	
            <!-- Footer starts here -->
            <div id="footer">
                <p>&copy; TechE</p>
            </div>
            <!-- Footer starts here -->
	

</div>


</body>
</html>