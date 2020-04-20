CREATE TABLE IF NOT EXISTS `logging` (
	`id` PRIMARY KEY INT(11) NULL AUTOINCREMENT,
	`type` TEXT NOT NULL,
	`description` TEXT NOT NULL,
	`identifier` TEXT NOT NULL,
	`name` TEXT NOT NULL,
	`on_date` DATETIME NOT NULL CURRENT_TIMESTAMP,
	UNIQUE(`id`, `identifier`, `name`)
);