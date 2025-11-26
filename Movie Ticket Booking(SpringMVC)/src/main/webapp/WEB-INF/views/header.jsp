<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<nav style="background: linear-gradient(135deg, #667eea 0%, #764ba2 100%); padding: 1rem 2rem; box-shadow: 0 2px 10px rgba(0,0,0,0.1);">
    <div style="max-width: 1200px; margin: 0 auto; display: flex; justify-content: space-between; align-items: center;">
        <div style="display: flex; align-items: center; gap: 2rem;">
            <a href="${pageContext.request.contextPath}/" style="text-decoration: none;">
                <h1 style="color: white; margin: 0; font-size: 1.8rem; font-weight: bold;">🎬 MovieBox</h1>
            </a>
            <div style="display: flex; gap: 1.5rem;">
                <a href="${pageContext.request.contextPath}/" style="color: white; text-decoration: none; font-weight: 500; transition: opacity 0.3s;">Home</a>
                <a href="${pageContext.request.contextPath}/movies" style="color: white; text-decoration: none; font-weight: 500; transition: opacity 0.3s;">Movies</a>
                <a href="${pageContext.request.contextPath}/about" style="color: white; text-decoration: none; font-weight: 500; transition: opacity 0.3s;">About</a>
            </div>
        </div>
        
        <div style="display: flex; align-items: center; gap: 1rem;">
            <c:choose>
                <c:when test="${not empty sessionScope.username}">
                    <span style="color: white; font-weight: 500;">Welcome, ${sessionScope.username}!</span>
                    <a href="${pageContext.request.contextPath}/my-bookings" 
                       style="background: rgba(255,255,255,0.2); color: white; padding: 0.5rem 1.5rem; border-radius: 25px; text-decoration: none; font-weight: 500; border: 1px solid rgba(255,255,255,0.3); transition: all 0.3s;">
                        My Bookings
                    </a>
                    <a href="${pageContext.request.contextPath}/logout" 
                       style="background: rgba(255,255,255,0.2); color: white; padding: 0.5rem 1.5rem; border-radius: 25px; text-decoration: none; font-weight: 500; border: 1px solid rgba(255,255,255,0.3); transition: all 0.3s;">
                        Logout
                    </a>
                </c:when>
                <c:otherwise>
                    <a href="${pageContext.request.contextPath}/register" 
                       style="background: rgba(255,255,255,0.2); color: white; padding: 0.5rem 1.5rem; border-radius: 25px; text-decoration: none; font-weight: 500; border: 1px solid rgba(255,255,255,0.3); transition: all 0.3s;">
                        Register
                    </a>
                    <a href="${pageContext.request.contextPath}/login" 
                       style="background: white; color: #667eea; padding: 0.5rem 1.5rem; border-radius: 25px; text-decoration: none; font-weight: 600; transition: all 0.3s; box-shadow: 0 2px 8px rgba(0,0,0,0.1);">
                        Login
                    </a>
                </c:otherwise>
            </c:choose>
        </div>
    </div>
</nav>