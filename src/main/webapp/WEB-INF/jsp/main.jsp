<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/jsp/taglib.jspf" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>

<script src="https://cdnjs.cloudflare.com/ajax/libs/crypto-js/4.2.0/crypto-js.min.js"></script>
</head>
<body>

	<div>
		<h1>AES 256</h1>
		<div>Java 암호화 : ${encryptedText}</div>
		<div>JavaScript 암호화 : <span id="enText"></span></div>
		<br/>
		<div>Java 복호화 : ${decryptedText}</div>
		<div>JavaScript 복호화 : <span id="deText"></span></div>
	</div>

	<script type="module">
		import * as aesCrypto from "/js/module/aesCrypto.js";

		const secretKey = '<spring:eval expression="@environment.getProperty('aes.secret.key')" />';
		const iv = '<spring:eval expression="@environment.getProperty('aes.iv')" />';

		const encryptedText = aesCrypto.encrypt(secretKey, iv, 'hello');
		document.querySelector('#enText').innerText = encryptedText;

		const decryptedText = aesCrypto.decrypt(secretKey, iv, encryptedText);
		document.querySelector('#deText').innerText = decryptedText;
	</script>

</body>
</html>