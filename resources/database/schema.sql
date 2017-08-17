CREATE TABLE `products` (
  `product_id` int(11) NOT NULL,
  `product_name` varchar(45) DEFAULT NULL,
  `per_unit_type` varchar(45) DEFAULT NULL,
  `per_unit_cost` varchar(45) DEFAULT NULL,
  `product_family` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`product_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='products database for demonstrations'

CREATE TABLE `product_descriptions` (
  `product_id` int(11) NOT NULL,
  `long_text` varchar(1000) DEFAULT NULL,
  PRIMARY KEY (`product_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8