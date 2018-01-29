package com.ohhoonim.outgoing.web;

import java.util.HashMap;

import javax.annotation.Resource;

import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.ohhoonim.outgoing.service.OutgoingService;

@Controller
public class OutgoingController {
	@Resource(name="outgoingService")
	OutgoingService outgoingService;
	
	@RequestMapping("/outgoing/outgoingList.do")
	public String outgoingCreate(@RequestParam HashMap<String,String>req, ModelMap model) {
		
		return null;
	}
	
	@RequestMapping("/outgoing/outgoing-001.do")
	public String outgoingList(@RequestParam HashMap<String,String>req, ModelMap model) {
		
		return null;
	}
	
	@RequestMapping("/outgoing/outgoing-002.do")
	public String outgoingModify(@RequestParam HashMap<String,String>req, ModelMap model) {
		
		return null;
	}
	
	@RequestMapping("/outgoing/outgoing-003.do")
	public String outgoingDelete(@RequestParam HashMap<String,String>req, ModelMap model) {
		
		return null;
	}
	
	@RequestMapping("/outgoing/outgoing-004.do")
	public String outgoingCancel(@RequestParam HashMap<String,String>req, ModelMap model) {
		
		return null;
	}

}