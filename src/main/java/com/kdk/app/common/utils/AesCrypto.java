package com.kdk.app.common.utils;

import java.nio.charset.StandardCharsets;
import java.util.Base64;

import javax.crypto.Cipher;
import javax.crypto.SecretKey;
import javax.crypto.spec.IvParameterSpec;
import javax.crypto.spec.SecretKeySpec;

/**
 * <pre>
 * -----------------------------------
 * 개정이력
 * -----------------------------------
 * 2024. 6. 15. 김대광	최초작성
 * </pre>
 *
 *
 * @author 김대광
 */
public class AesCrypto {

	private AesCrypto() {
		super();
	}

	private static class LazyHolder {
		private static final AesCrypto INSTANCE = new AesCrypto();
	}

	public static AesCrypto getInstance() {
		return LazyHolder.INSTANCE;
	}

	private final String AES_CBC_PKCS5PADDING ="AES/CBC/PKCS5Padding";
	private final String CHARSET = StandardCharsets.UTF_8.toString();

	public String encrypt(String secretKey, String iv, String text) {
		try {
			SecretKey secretKeySpec = new SecretKeySpec(secretKey.getBytes(), "AES");

			Cipher cipher = Cipher.getInstance(AES_CBC_PKCS5PADDING);
			cipher.init(Cipher.ENCRYPT_MODE, secretKeySpec, new IvParameterSpec(iv.getBytes()));

			byte[] textBytes = cipher.doFinal(text.getBytes(CHARSET));

			return Base64.getEncoder().encodeToString(textBytes);

		} catch (Exception e) {
			return text;
		}
	}

	public String decrypt(String secretKey, String iv, String encryptedText) {
		try {
			SecretKey secretKeySpec = new SecretKeySpec(secretKey.getBytes(), "AES");

			Cipher cipher = Cipher.getInstance(AES_CBC_PKCS5PADDING);
			cipher.init(Cipher.DECRYPT_MODE, secretKeySpec, new IvParameterSpec(iv.getBytes()));

			byte[] textBytes = Base64.getDecoder().decode(encryptedText.getBytes(CHARSET));

			return new String(cipher.doFinal(textBytes));

		} catch (Exception e) {
			return encryptedText;
		}
	}

}
