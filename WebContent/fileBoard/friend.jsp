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