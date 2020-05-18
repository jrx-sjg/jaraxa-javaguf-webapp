package com.jaraxa.app.core.web.controller;


import java.io.InputStream;

import org.apache.commons.io.IOUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.CacheControl;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.RestController;
import com.jaraxa.app.core.service.PicturesService;

@RestController
@RequestMapping("/pictures")
public class PicturesController {

	@Autowired
	private PicturesService picturesService;

	private static final Logger logger = LoggerFactory.getLogger(PicturesController.class);

	@GetMapping("{group}/{id}")
	@ResponseBody
	public ResponseEntity<byte[]> getPictureAsResource(@PathVariable("group") String group, @PathVariable("id") String id) {
		
		HttpHeaders headers = new HttpHeaders();
		headers.setCacheControl(CacheControl.noCache().getHeaderValue());
		headers.setContentType(MediaType.IMAGE_JPEG);
		
		byte[] media = null;
		try (InputStream in = picturesService.getById(group, id);){
			media = IOUtils.toByteArray(in);
			return new ResponseEntity<byte[]>(media, headers, HttpStatus.OK);
		} catch (Exception e) {
			logger.debug("missing picture - id:{} - message:{}", e.getMessage());
			return new ResponseEntity<byte[]>(HttpStatus.NOT_FOUND);
		}
	}

}
