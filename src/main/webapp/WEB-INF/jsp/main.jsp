<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/jsp/taglib.jspf" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>

<script src="https://cdnjs.cloudflare.com/ajax/libs/crypto-js/4.2.0/crypto-js.min.js"></script>

<script>
const encrypt = (secretKey, iv, text) => {
    const cipher = CryptoJS.AES.encrypt(text, CryptoJS.enc.Utf8.parse(secretKey), {
        iv: CryptoJS.enc.Utf8.parse(iv),
        padding: CryptoJS.pad.Pkcs7,
        mode: CryptoJS.mode.CBC,
    });

    return cipher.toString();
}

const decrypt = (secretKey, iv, encryptedText) => {
    const decipher = CryptoJS.AES.decrypt(encryptedText, CryptoJS.enc.Utf8.parse(secretKey), {
        iv: CryptoJS.enc.Utf8.parse(iv),
        padding: CryptoJS.pad.Pkcs7,
        mode: CryptoJS.mode.CBC,
    })

    return decipher.toString(CryptoJS.enc.Utf8);
}

/*
 	Front의 경우, CDN 대신
 		npm install crypto-js
 		import CryptoJS from "crypto-js";
 */
</script>

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

	<script>
		const secretKey = '<spring:eval expression="@environment.getProperty('aes.secret.key')" />';
		const iv = '<spring:eval expression="@environment.getProperty('aes.iv')" />';

		const encryptedText = encrypt(secretKey, iv, 'hello');
		document.querySelector('#enText').innerText = encryptedText;

		const decryptedText = decrypt(secretKey, iv, encryptedText);
		document.querySelector('#deText').innerText = decryptedText;
	</script>

</body>
</html>