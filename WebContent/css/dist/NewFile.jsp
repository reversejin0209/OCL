<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c"      uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix = "fn" 	uri = "http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<title><spring:message code="code.m00725" /></title>
<script type="text/javascript">
	

	$(document).ready(function() {
	});
	
	function move(item_wrd_id){ 
        var url    = "<c:url value='/popup/main2110/list.do?item_wrd_id='/>"+item_wrd_id;
        window.location.href=url;
    }
	
	function goBack(){
		window.history.back();
	}
	
	function winPopup(url, customWidth, customHeight) {
        var popWidth, popHeight, option;
        popWidth = screen.availWidth - 30;
        popHeight = screen.availHeight - 80;
        if (customWidth !== undefined && customWidth !== null && !isNaN(customWidth) && customWidth > 0) {
            popWidth = customWidth;
            console.log(customWidth);
        }
        if (customHeight !== undefined && customHeight !== null && !isNaN(customHeight) && customHeight > 0) {
            popHeight = customHeight;
            console.log(customHeight);
        }
        option = "resizable=yes,scrollbars=yes,status=no,left=0,top=0,width=" + popWidth + ", height=" + popHeight;
        window.open(url, "", option);
     }
	
</script>
</head>
<body>
	<div class="app win-popup">
    <div class="header-wrap popup-header">
        <div class="inner-wrap">
            <h2 class="page-title">정보공시 용어사전</h2>
        </div>
    </div>
    <div id="contentsWrap" class="contents-wrap">
        <div class="contents-inner-wrap">
            <div class="inner-wrap">
                <!--S: 이전, 인쇄 버튼 -->
                <div class="btn-wrap text-right">
                    <button type="button" class="btn icon-back-page" onclick="goBack();">이전</button>
                    <button type="button" class="btn icon-print" onclick="window.print();">인쇄</button>
                </div>
                <!--E: 이전, 인쇄 버튼 -->

                <!--S: 설명 -->
                <ol class="text-list">
                    <!-- S:공시용어 항목 설명-->
                    <li>
                        <span class="text-list-title">${item.item_wrd_nm}</span>
                        <div class="gray-line-box">
                            ${item.item_wrd_expl_ctnt}
                        </div>
                    </li>
                    <!-- E:공시용어 항목 설명-->
                    <!--S: 해당항목 평균 정보 -->
                    
                        <c:choose>
							<c:when test="${not empty itemAvg}">
								<li>
									<span class="text-list-title">평균 정보 요약</span>
			                        <div class="tbl-wrap">
			                            <table class="tbl-col">
			                                <caption>평균 정보 요약 목록 테이블</caption>
			                                <colgroup>
			                                    <col style="width:20%;">
			                                    <col style="width:16%">
			                                    <col style="width:16%">
			                                    <col style="width:16%">
			                                    <col style="width:16%">
			                                    <col style="width:16%">
			                                </colgroup>
			                                <thead>
			                                <tr>
			                                    <th scope="col">학제구분</th>
			                                    <th scope="col">전국평균</th>
			                                    <th scope="col">국·공립평균</th>
			                                    <th scope="col">사립평균</th>
			                                    <th scope="col">수도권평균</th>
			                                    <th scope="col">비수도권평균</th>
			                                </tr>
			                                </thead>
			                                <tbody>
			                                <c:forEach items="${itemAvg}" var="itemAvg">
			                                    <tr>
			                                        <td>${itemAvg.schl_div_nm}</td>          
			                                        <td>${itemAvg.wnty_univ_ctnt}${itemAvg.unit_nm}</td>
			                                        <td>${itemAvg.npin_univ_ctnt}${itemAvg.unit_nm}</td>
			                                        <td>${itemAvg.pvtestb_univ_ctnt}${itemAvg.unit_nm}</td>
			                                        <td>${itemAvg.npln_univ_ctnt}${itemAvg.unit_nm}</td>
			                                        <td>${itemAvg.nmet_univ_ctnt}${itemAvg.unit_nm}</td>
			                                    </tr>
			                                </c:forEach>
			                                </tbody>
			                            </table>
			                        </div>
			                    </li>
						</c:when>
					</c:choose>
                       
                    <!--E: 해당항목 평균 정보 -->
                    <!--S: 연관 용어 링크 -->
                    <c:choose>
                        <c:when test="${not empty explCtnt}">
		                    <li>
		                        <span class="text-list-title">연관 용어</span>
		                        <div class="gray-bg-box light">
		                            <ul class="relative-term">
		                                <!-- button type -->
		                                <c:forEach items="${explCtnt}" var="obj">
		                                    <li><button type="button" class="word-link" onclick="move('${obj.item_wrd_id}')"><td>${obj.item_wrd_nm}</td> </button></li>
		                                    <li><button type="button" class="word-link" onclick="javascript:winPopup('/popup/main2110/list.do?item_wrd_id=${obj.item_wrd_id}' ,'1160');"><td>${obj.item_wrd_nm}</td> </button></li>
		                                    
		                                </c:forEach>
		                            </ul>
		                        </div>
		                    </li>
                        </c:when>
                    </c:choose>		                   
                    <!--E: 연관 용어 링크 -->
                </ol>
                <!--E: 설명 -->


            </div>
        </div>
    </div>
</div>

</body>
</html>            
 

2. 컨트롤러

package kr.or.kcue.main.main2110.controller;

import java.util.List;
import java.util.Locale;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springmodules.validation.commons.DefaultBeanValidator;

import egovframework.rte.fdl.property.EgovPropertyService;
import kr.foxsoft.frame.common.dto.MapDto;
import kr.or.kcue.main.main2110.service.main2110Service;

/**
 * @Class Name : main2110Controller.java
 * @Description : main2110 Controller Class
 * @Modification Information
 * @
 * @  수정일      수정자              수정내용
 * @ ---------   ---------   -------------------------------
 * @ 2019.10.22          최초생성
 *
 * @author  
 * @since 
 * @version 1.0
 * @see
 *
 *  
 */
@Controller
public class main2110Controller {
	/** EgovPropertyService */
	@Resource(name = "propertiesService")
	protected EgovPropertyService propertiesService;
	
	/** Validator */
	@Resource(name = "beanValidator")
	protected DefaultBeanValidator beanValidator;
	
	@Resource(name = "main2110Service")
	protected main2110Service main2110Service; 
	
	
	
	@RequestMapping(value = "/popup/main2110/list.do")
	public String doInit(@RequestParam Map<String, Object> pramMap, ModelMap model, Locale locale) throws Exception {
		
		Map item = main2110Service.selectItem(pramMap, locale); // 정보공시 용어사전
		String itemWrdId = item.get("item_wrd_id").toString();  
		String itemAvrgDivCd = item.get("item_avrg_div_cd").toString();
		
		pramMap.put("itemWrdId" , itemWrdId	 ); 
		pramMap.put("itemAvrgDivCd" , itemAvrgDivCd	 );
		
		List< MapDto> explCtnt = main2110Service.selectExplCtnt(pramMap, locale);  // 연관용어
		List< MapDto> itemAvg = main2110Service.selectItemAvg(pramMap, locale);  // 평균 정보 요약
		
		model.addAttribute("item", item);
		model.addAttribute("explCtnt", explCtnt);
		model.addAttribute("itemAvg", itemAvg);
        
		return "main/main2110";
	}

}
 

3.서비스

/*
 * Copyright 2008-2009 the original author or authors.
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *      http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */
package kr.or.kcue.main.main2110.service;

import java.util.List;
import java.util.Locale;
import java.util.Map;

import kr.foxsoft.frame.common.dto.MapDto;

/**
 * @Class Name : main2070Service.java
 * @Description : main2070Service Class
 * @Modification Information
 * @
 * @  수정일      수정자              수정내용
 * @ ---------   ---------   -------------------------------
 * @ 2019.10.21  PIK           최초생성
 *
 * @author PIK
 * @since 2019.10.21
 * @version 1.0
 * @see
 *
 *  
 */
public interface main2110Service {
	
	public MapDto selectItem(Map<String, Object> pramMap, Locale locale) throws Exception;
	public List<MapDto> selectExplCtnt(Map<String, Object> pramMap, Locale locale) throws Exception;
	public List<MapDto> selectItemAvg(Map<String, Object> pramMap, Locale locale) throws Exception;	
}

4.서비스  임플

package kr.or.kcue.main.main2110.service.impl;

import java.util.List;
import java.util.Locale;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import kr.foxsoft.frame.common.dto.MapDto;
import kr.or.kcue.main.main2110.dao.main2110DAO;
import kr.or.kcue.main.main2110.service.main2110Service;

@Service("main2110Service")
public class main2110ServiceImpl implements main2110Service{
	
	/** main0081DAO */
	@Resource(name = "main2110DAO")
	private main2110DAO dao;
	
	/**
	 * 정보공시 용어사전를 가져온다.
	 * @param searchMap - 조회할 정보가 담긴 Map
	 * @return 정보공시 용어사전
	 * @exception Exception
	 */
	public MapDto selectItem(Map<String, Object> pramMap, Locale locale) throws Exception {
		return dao.selectItem(pramMap,locale);
	}
	
	/**
	 * 연관용어를 가져온다.
	 * @param searchMap - 조회할 정보가 담긴 Map
	 * @return 연관용어
	 * @exception Exception  
	 */
	public List<MapDto> selectExplCtnt(Map<String, Object> pramMap, Locale locale) throws Exception {
		return dao.selectExplCtnt(pramMap,locale);
	}
	
	/**
	 * 평균 정보 요약을 가져온다.
	 * @param searchMap - 조회할 정보가 담긴 Map
	 * @return평균 정보 요약
	 * @exception Exception  
	 */
	public List<MapDto> selectItemAvg(Map<String, Object> pramMap, Locale locale) throws Exception {
		return dao.selectItemAvg(pramMap,locale);
	}
	
	

}
5. DAO

package kr.or.kcue.main.main2110.dao;

import java.util.List;
import java.util.Locale;
import java.util.Map;

import org.springframework.stereotype.Repository;

import kr.foxsoft.frame.common.dao.CommonAbstractDAO;
import kr.foxsoft.frame.common.dto.MapDto;

@Repository("main2110DAO")
public class main2110DAO extends CommonAbstractDAO{
	public String namespace_code = "kr.or.kcue.main.main2110.mapper.main2110Mapper";
	
	/**
	 * 정보공시 용어사전를 가져온다.
	 * @param searchMap - 조회할 정보가 담긴 Map
	 * @return 정보공시 용어사전
	 * @exception Exception
	 */
	public MapDto selectItem(Map<String, Object> map, Locale locale) throws Exception {
		return selectOne(namespace_code+".selectItem", map);
	}
	/**
	 * 연관용어를 가져온다.
	 * @param searchMap - 조회할 정보가 담긴 Map
	 * @return 연관용어
	 * @exception Exception  
	 */
	public List<MapDto> selectExplCtnt(Map<String, Object> pramMap, Locale locale) throws Exception{
		return selectList(namespace_code+".selectExplCtnt", pramMap);
	}
	
	/**
	 * 평균 정보 요약을 가져온다.
	 * @param searchMap - 조회할 정보가 담긴 Map
	 * @return평균 정보 요약
	 * @exception Exception  
	 */
	public List<MapDto> selectItemAvg(Map<String, Object> pramMap, Locale locale) throws Exception{
		return selectList(namespace_code+".selectItemAvg", pramMap);
	}
	
}
6. 맵퍼

<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE mapper PUBLIC "-//mybatis.org//DTD Mapper 3.0//EN" "http://mybatis.org/dtd/mybatis-3-mapper.dtd">
<mapper namespace="kr.or.kcue.main.main2110.mapper.main2110Mapper">

	<select id="selectItem" parameterType="pramMap" resultType="mapDto"  >
        /* 정보공시 용어사전 */
         SELECT ITEM_WRD_ID,ITEM_WRD_NM,ITEM_AVRG_DIV_CD
			,(SELECT DBMS_LOB.SUBSTR(ITEM_WRD_EXPL_CTNT, 20000, 1) FROM  CBB1100D WHERE ITEM_WRD_ID = F.ITEM_WRD_ID ) AS ITEM_WRD_EXPL_CTNT
			, F.* 
		FROM CBB1000F F
		WHERE 1=1
		<if test="item_wrd_id != null and item_wrd_id != ''">
	       AND ITEM_WRD_ID = #{item_wrd_id}
        </if>
        <if test="itemWrdNm != null and itemWrdNm != ''">
           AND UPPER(replace(ITEM_WRD_NM, ' ', '') ) = UPPER(replace(#{itemWrdNm},' ', '') )
        </if>
		
	</select>
		
	<select id="selectExplCtnt" parameterType="pramMap" resultType="mapDto"  >
        <![CDATA[
        /*연관용어*/
        select ITEM_WRD_ID,ITEM_WRD_NM
        from cbb1000f
		where ITEM_WRD_ID in (
		    select ASSO_ITEM_WRD_ID from cbb1200r
		    where ITEM_WRD_ID = #{itemWrdId}
		)
    ]]>  