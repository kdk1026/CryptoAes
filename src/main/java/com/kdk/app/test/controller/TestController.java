package com.kdk.app.test.controller;

import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.servlet.ModelAndView;

import com.kdk.app.common.utils.AesCrypto;

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
@Controller
public class TestController {

	@Value("${aes.secret.key}")
	private String secretKey;

	@Value("${aes.iv}")
	private String iv;

	@GetMapping("/")
	public ModelAndView main() {
		ModelAndView mav = new ModelAndView();

		String encryptedText = AesCrypto.getInstance().encrypt(secretKey, iv, "hello");
		mav.addObject("encryptedText", encryptedText);

		String decryptedText = AesCrypto.getInstance().decrypt(secretKey, iv, encryptedText);
		mav.addObject("decryptedText", decryptedText);

		mav.setViewName("main");
		return mav;
	}

}
