		<div class="paging">
			<c:if test="${startPage > BLOCKSIZE }">
				[ <a href="${conPath }/FileBoardList.do?pageNum=${startPage-1}"> 이전 </a> ]
			</c:if>
			<c:forEach var="i" begin="${startPage }" end="${endPage }">
				<c:if test="${i == pageNum }">
					<b> [ ${i } ] </b>
				</c:if>
				<c:if test="${i != pageNum }">
					[ <a href="${conPath }/FileBoardList.do?pageNum=${i}"> ${i } </a> ]
				</c:if>
			</c:forEach>
			<c:if test="${endPage<pageCnt }">
			  [ <a href="${conPath }/FileBoardList.do?pageNum=${endPage+1}"> 다음 </a> ]
			</c:if>
		</div>
		
				<table>
			<caption>게시판글등록</caption>
			<tr>
				<td>제목</td><td><input type="text" name="ftitle" required="required"></td>
			</tr>
			<tr>
				<td>본문</td><td><textarea name="fcontent" rows="5"></textarea></td>
			</tr>
			<tr>
				<td>첨부파일</td><td><input type="file" name="ffileName"></td>
			</tr>
			<tr><td colspan="2">
				<input type="submit" value="글쓰기" class="btn">
				<input type="reset" vlaue="취소" class="btn">
				<input type="button" value="목록" class="btn"
					onclick="location.href='${conPath}/FileBoardList.do'"
														FileBoardList
				>
			</td>
			</tr>
		</table>
		<form action="${conPath }/join.do" method="post"
		enctype="multipart/form-data">
		<table>

			<tr>
				<th>비밀번호</th>
				<td><input type="password" name="spw" required="required"></td>
			</tr>
			<tr>
				<th>비밀번호</th>
				<td><input type="password" name="spwChk" required="required">
					<div id="spwChkResult">&nbsp;</div></td>
			</tr>
			<tr>
				<th>이름</th>
				<td><input type="text" name="sname" required="required"></td>
			</tr>
			<tr>
				<th>전화번호</th>
				<td><input type="text" name="snumber"></td>
			</tr>
			<tr>
				<th>생년월일</th>
				<td><input type="text" name="sbirth" id="datepicker"></td>
			</tr>
			<tr>
				<th>메일</th>
				<td><input type="text" name="semail">
					<div id="semailConfirmResult">&nbsp;</div></td>
			</tr>
			<tr>
				<th>성별</th>
				<td><input type="radio" name="sgender" value="m">남 <input
					type="radio" name="sgender" value="f">여</td>
			</tr>
			<tr>
				<th>사진</th>
				<td><input type="file" name="sphoto"></td>
			</tr>
			<tr>
				<th>주소</th>
				<td><input type="text" name="saddress"></td>
			</tr>
			<tr>
				<td colspan="2">
					<p>
						<input type="submit" value="회원가입" class="btn"> <input
							type="button" value="로그인" class="btn"
							onclick="location='${conPath}/loginView.do'">
					</p>
				</td>
			</tr>
		</table>
	</form>
	
	
	
	<body>
	<c:if test="${empty student }">
		<script>location.href='${conPath}/loginView.do?next=modifyView.do';</script>
	</c:if>
	<div id="content_form">
		<form action="${conPath }/modify.do" method="post" enctype="multipart/form-data">
			<input type="hidden" name="dbSpw" value="${student.spw }">
			<input type="hidden" name="dbSphoto" value="${student.sphoto }">
			<table>
				<caption>정보수정</caption>
				<tr>
					<th>아이디</th>
					<td>
						<input type="text" name="sid" value="${student.sid }" readonly="readonly" size="3">
					</td>
					<td rowspan="4">
						<img src="${conPath }/studentPhotoUp/${student.sphoto}"
								 alt="${student.sname }사진">
					</td>
				</tr>
				<tr>
					<th>현비밀번호</th>
					<td>
						<input type="password" name="oldSpw">
					 </td>
				</tr>
				<tr>
					<th>새비밀번호</th>
					<td><input type="password" name="spw" size="3"></td>
				</tr>
				<tr>
					<th>이름</th>
					<td>
						<input type="text" name="sname" value="${student.sname }" required="required" size="3">
					</td>
				</tr>
				<tr>
					<th>메일</th>
					<td colspan="2">
						<input type="email" name="semail" value="${student.semail }">
						<div id="semailConfirmResult"> &nbsp; </div>
					</td>
				</tr>
				<tr>
					<th>사진</th>
					<td colspan="2">
						<input type="file" name="sphoto">
					</td>
				</tr>
				<tr>
					<th>생년월일</th>
					<td colspan="2">
						<input type="text" name="sbirth" value="${student.sbirth }"
							id="datepicker">
					</td>
				</tr>
				<tr>
					<th>주소</th>
					<td colspan="2">
						<input type="text" name="saddress" value="${student.saddress }">
					</td>
				</tr>
				<tr>
					<td colspan="3">
						<input type="submit" value="정보수정" class="btn">
						<input type="reset" value="초기화" class="btn">
						<input type="reset" value="이전" onclick="history.back()" class="btn">
						<input type="button" value="회원탈퇴" class="btn"
							onclick="location.href='${conPath}/withdrawal.do'">
					</td>
				</tr>
			</table>
		</form>
	</div>
</body>
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	