package com.sportmall.filter;

import com.sportmall.entity.IRole;
import com.sportmall.entity.TUser;

import java.io.IOException;

import javax.servlet.Filter;
import javax.servlet.FilterChain;
import javax.servlet.FilterConfig;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.annotation.WebFilter;
import javax.servlet.http.HttpServletRequest;


/**
 * Servlet Filter implementation class AdminFilter
 */
@WebFilter(urlPatterns="/back/*")
public class AdminFilter implements Filter {

    /**
     * Default constructor. 
     */
    public AdminFilter() {
    	System.out.println("AdminFilter  start");
    }

	/**
	 * @see Filter#destroy()
	 */
	public void destroy() {
	
	}

	/**
	 * @see Filter#doFilter(ServletRequest, ServletResponse, FilterChain)
	 */
	public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain) throws IOException, ServletException {

		HttpServletRequest req = (HttpServletRequest)request;

		Object obj = req.getSession().getAttribute("user");
		if(obj == null){
			req.setAttribute("msg", "无权访问，先登录");
			req.getRequestDispatcher("/WEB-INF/views/login.jsp").forward(req, response);
		}else{
			TUser user = (TUser)obj;
			if(user.getRole() == IRole.ADMIN){
				chain.doFilter(request, response);                    //����ԭ��������	
			}else{
				req.setAttribute("msg", "无权访问，级别不足");
				req.getRequestDispatcher("/WEB-INF/views/login.jsp").forward(req, response);
			}						
		}
	}

	/**
	 * @see Filter#init(FilterConfig)
	 */
	public void init(FilterConfig fConfig) throws ServletException {
		// TODO Auto-generated method stub
	}

}
