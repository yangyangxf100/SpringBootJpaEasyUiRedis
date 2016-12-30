package com.yy.boot;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.boot.CommandLineRunner;
import org.springframework.core.annotation.Order;
import org.springframework.core.annotation.OrderUtils;
import org.springframework.stereotype.Component;

import java.util.Arrays;

@Component
@Order(5)
public class MyCmdLineRunner2 implements CommandLineRunner {
	private static final Logger log = LoggerFactory.getLogger(MyCmdLineRunner2.class);

	public void run(String... args) {
		log.info("MyCmdLineRunner2::order=" + OrderUtils.getOrder(this.getClass()) + ":args=" + Arrays.toString(args));
	}
}