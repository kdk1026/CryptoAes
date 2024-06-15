/*
	Front의 경우, CDN 대신
 		npm install crypto-js
 		import CryptoJS from "crypto-js";
*/

export const encrypt = (secretKey, iv, text) => {
    const cipher = CryptoJS.AES.encrypt(text, CryptoJS.enc.Utf8.parse(secretKey), {
        iv: CryptoJS.enc.Utf8.parse(iv),
        padding: CryptoJS.pad.Pkcs7,
        mode: CryptoJS.mode.CBC,
    });

    return cipher.toString();
}

export const decrypt = (secretKey, iv, encryptedText) => {
    const decipher = CryptoJS.AES.decrypt(encryptedText, CryptoJS.enc.Utf8.parse(secretKey), {
        iv: CryptoJS.enc.Utf8.parse(iv),
        padding: CryptoJS.pad.Pkcs7,
        mode: CryptoJS.mode.CBC,
    })

    return decipher.toString(CryptoJS.enc.Utf8);
}