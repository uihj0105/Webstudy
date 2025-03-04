package com.sist.model;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.sist.controller.RequestMapping;
import java.util.*;
import com.sist.dao.*;
import com.sist.vo.SeoulVO;
public class SeoulModel {
	// => if : => 
	@RequestMapping("seoul/location.do")
	public String seoul_location(HttpServletRequest request,
			  HttpServletResponse response)
	{
		  // DB연동 
		  //1. 요청값 받기
		  String page=request.getParameter("page");
		  if(page==null)
			  page="1";
		  int curpage=Integer.parseInt(page);
		  //2. DB연동 
		  SeoulDAO dao=new SeoulDAO();
		  List<SeoulVO> list=dao.seoulLocationListData(curpage,"seoul_location");
		  int totalpage=dao.seoulLocationTotalPage("seoul_location");
		  
		  request.setAttribute("curpage", curpage);
		  request.setAttribute("totalpage", totalpage);
		  request.setAttribute("list", list);
		  //3. 결과값 모아서 request에 저장 
		  request.setAttribute("main_jsp", "../seoul/location.jsp");
		  return "../main/main.jsp";
	}
	@RequestMapping("seoul/nature.do")
	public String seoul_nature(HttpServletRequest request,
			  HttpServletResponse response)
	{
		  // DB연동 
		  //1. 요청값 받기
		  String page=request.getParameter("page");
		  if(page==null)
			  page="1";
		  int curpage=Integer.parseInt(page);
		  //2. DB연동 
		  SeoulDAO dao=new SeoulDAO();
		  System.out.println("seoul-dao="+dao);
		  List<SeoulVO> list=dao.seoulLocationListData(curpage,"seoul_nature");
		  int totalpage=dao.seoulLocationTotalPage("seoul_nature");
		  
		  request.setAttribute("curpage", curpage);
		  request.setAttribute("totalpage", totalpage);
		  request.setAttribute("list", list);
		  //3. 결과값 모아서 request에 저장 
		  request.setAttribute("main_jsp", "../seoul/nature.jsp");
		  return "../main/main.jsp";
	}
}