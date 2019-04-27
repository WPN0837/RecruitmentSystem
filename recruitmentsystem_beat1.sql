/*
 Navicat Premium Data Transfer

 Source Server         : localhost
 Source Server Type    : MySQL
 Source Server Version : 50725
 Source Host           : localhost:3306
 Source Schema         : recruitmentsystem

 Target Server Type    : MySQL
 Target Server Version : 50725
 File Encoding         : 65001

 Date: 27/04/2019 16:47:01
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for auth_group
-- ----------------------------
DROP TABLE IF EXISTS `auth_group`;
CREATE TABLE `auth_group`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(80) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `name`(`name`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for auth_group_permissions
-- ----------------------------
DROP TABLE IF EXISTS `auth_group_permissions`;
CREATE TABLE `auth_group_permissions`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `group_id` int(11) NOT NULL,
  `permission_id` int(11) NOT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `auth_group_permissions_group_id_permission_id_0cd325b0_uniq`(`group_id`, `permission_id`) USING BTREE,
  INDEX `auth_group_permissio_permission_id_84c5c92e_fk_auth_perm`(`permission_id`) USING BTREE,
  CONSTRAINT `auth_group_permissio_permission_id_84c5c92e_fk_auth_perm` FOREIGN KEY (`permission_id`) REFERENCES `auth_permission` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `auth_group_permissions_group_id_b120cbf9_fk_auth_group_id` FOREIGN KEY (`group_id`) REFERENCES `auth_group` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for auth_permission
-- ----------------------------
DROP TABLE IF EXISTS `auth_permission`;
CREATE TABLE `auth_permission`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `content_type_id` int(11) NOT NULL,
  `codename` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `auth_permission_content_type_id_codename_01ab375a_uniq`(`content_type_id`, `codename`) USING BTREE,
  CONSTRAINT `auth_permission_content_type_id_2f476e4b_fk_django_co` FOREIGN KEY (`content_type_id`) REFERENCES `django_content_type` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 133 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of auth_permission
-- ----------------------------
INSERT INTO `auth_permission` VALUES (1, 'Can add log entry', 1, 'add_logentry');
INSERT INTO `auth_permission` VALUES (2, 'Can change log entry', 1, 'change_logentry');
INSERT INTO `auth_permission` VALUES (3, 'Can delete log entry', 1, 'delete_logentry');
INSERT INTO `auth_permission` VALUES (4, 'Can view log entry', 1, 'view_logentry');
INSERT INTO `auth_permission` VALUES (5, 'Can add permission', 2, 'add_permission');
INSERT INTO `auth_permission` VALUES (6, 'Can change permission', 2, 'change_permission');
INSERT INTO `auth_permission` VALUES (7, 'Can delete permission', 2, 'delete_permission');
INSERT INTO `auth_permission` VALUES (8, 'Can view permission', 2, 'view_permission');
INSERT INTO `auth_permission` VALUES (9, 'Can add group', 3, 'add_group');
INSERT INTO `auth_permission` VALUES (10, 'Can change group', 3, 'change_group');
INSERT INTO `auth_permission` VALUES (11, 'Can delete group', 3, 'delete_group');
INSERT INTO `auth_permission` VALUES (12, 'Can view group', 3, 'view_group');
INSERT INTO `auth_permission` VALUES (13, 'Can add user', 4, 'add_user');
INSERT INTO `auth_permission` VALUES (14, 'Can change user', 4, 'change_user');
INSERT INTO `auth_permission` VALUES (15, 'Can delete user', 4, 'delete_user');
INSERT INTO `auth_permission` VALUES (16, 'Can view user', 4, 'view_user');
INSERT INTO `auth_permission` VALUES (17, 'Can add content type', 5, 'add_contenttype');
INSERT INTO `auth_permission` VALUES (18, 'Can change content type', 5, 'change_contenttype');
INSERT INTO `auth_permission` VALUES (19, 'Can delete content type', 5, 'delete_contenttype');
INSERT INTO `auth_permission` VALUES (20, 'Can view content type', 5, 'view_contenttype');
INSERT INTO `auth_permission` VALUES (21, 'Can add session', 6, 'add_session');
INSERT INTO `auth_permission` VALUES (22, 'Can change session', 6, 'change_session');
INSERT INTO `auth_permission` VALUES (23, 'Can delete session', 6, 'delete_session');
INSERT INTO `auth_permission` VALUES (24, 'Can view session', 6, 'view_session');
INSERT INTO `auth_permission` VALUES (25, 'Can add 公司信息', 7, 'add_company');
INSERT INTO `auth_permission` VALUES (26, 'Can change 公司信息', 7, 'change_company');
INSERT INTO `auth_permission` VALUES (27, 'Can delete 公司信息', 7, 'delete_company');
INSERT INTO `auth_permission` VALUES (28, 'Can view 公司信息', 7, 'view_company');
INSERT INTO `auth_permission` VALUES (29, 'Can add 公司认证文件', 8, 'add_companyauthfile');
INSERT INTO `auth_permission` VALUES (30, 'Can change 公司认证文件', 8, 'change_companyauthfile');
INSERT INTO `auth_permission` VALUES (31, 'Can delete 公司认证文件', 8, 'delete_companyauthfile');
INSERT INTO `auth_permission` VALUES (32, 'Can view 公司认证文件', 8, 'view_companyauthfile');
INSERT INTO `auth_permission` VALUES (33, 'Can add 公司创始团队信息', 9, 'add_companyfoundingteam');
INSERT INTO `auth_permission` VALUES (34, 'Can change 公司创始团队信息', 9, 'change_companyfoundingteam');
INSERT INTO `auth_permission` VALUES (35, 'Can delete 公司创始团队信息', 9, 'delete_companyfoundingteam');
INSERT INTO `auth_permission` VALUES (36, 'Can view 公司创始团队信息', 9, 'view_companyfoundingteam');
INSERT INTO `auth_permission` VALUES (37, 'Can add 公司介绍', 10, 'add_companyintroduction');
INSERT INTO `auth_permission` VALUES (38, 'Can change 公司介绍', 10, 'change_companyintroduction');
INSERT INTO `auth_permission` VALUES (39, 'Can delete 公司介绍', 10, 'delete_companyintroduction');
INSERT INTO `auth_permission` VALUES (40, 'Can view 公司介绍', 10, 'view_companyintroduction');
INSERT INTO `auth_permission` VALUES (41, 'Can add 公司产品', 11, 'add_companyproduct');
INSERT INTO `auth_permission` VALUES (42, 'Can change 公司产品', 11, 'change_companyproduct');
INSERT INTO `auth_permission` VALUES (43, 'Can delete 公司产品', 11, 'delete_companyproduct');
INSERT INTO `auth_permission` VALUES (44, 'Can view 公司产品', 11, 'view_companyproduct');
INSERT INTO `auth_permission` VALUES (45, 'Can add 公司标签', 12, 'add_companytag');
INSERT INTO `auth_permission` VALUES (46, 'Can change 公司标签', 12, 'change_companytag');
INSERT INTO `auth_permission` VALUES (47, 'Can delete 公司标签', 12, 'delete_companytag');
INSERT INTO `auth_permission` VALUES (48, 'Can view 公司标签', 12, 'view_companytag');
INSERT INTO `auth_permission` VALUES (49, 'Can add 行业领域', 13, 'add_industrysector');
INSERT INTO `auth_permission` VALUES (50, 'Can change 行业领域', 13, 'change_industrysector');
INSERT INTO `auth_permission` VALUES (51, 'Can delete 行业领域', 13, 'delete_industrysector');
INSERT INTO `auth_permission` VALUES (52, 'Can view 行业领域', 13, 'view_industrysector');
INSERT INTO `auth_permission` VALUES (53, 'Can add 职位', 14, 'add_position');
INSERT INTO `auth_permission` VALUES (54, 'Can change 职位', 14, 'change_position');
INSERT INTO `auth_permission` VALUES (55, 'Can delete 职位', 14, 'delete_position');
INSERT INTO `auth_permission` VALUES (56, 'Can view 职位', 14, 'view_position');
INSERT INTO `auth_permission` VALUES (57, 'Can add 发布的招聘信息', 15, 'add_positioninfo');
INSERT INTO `auth_permission` VALUES (58, 'Can change 发布的招聘信息', 15, 'change_positioninfo');
INSERT INTO `auth_permission` VALUES (59, 'Can delete 发布的招聘信息', 15, 'delete_positioninfo');
INSERT INTO `auth_permission` VALUES (60, 'Can view 发布的招聘信息', 15, 'view_positioninfo');
INSERT INTO `auth_permission` VALUES (61, 'Can add 标签分类', 16, 'add_tagsort');
INSERT INTO `auth_permission` VALUES (62, 'Can change 标签分类', 16, 'change_tagsort');
INSERT INTO `auth_permission` VALUES (63, 'Can delete 标签分类', 16, 'delete_tagsort');
INSERT INTO `auth_permission` VALUES (64, 'Can view 标签分类', 16, 'view_tagsort');
INSERT INTO `auth_permission` VALUES (65, 'Can add 首页轮播图', 17, 'add_banner');
INSERT INTO `auth_permission` VALUES (66, 'Can change 首页轮播图', 17, 'change_banner');
INSERT INTO `auth_permission` VALUES (67, 'Can delete 首页轮播图', 17, 'delete_banner');
INSERT INTO `auth_permission` VALUES (68, 'Can view 首页轮播图', 17, 'view_banner');
INSERT INTO `auth_permission` VALUES (69, 'Can add 城市', 18, 'add_city');
INSERT INTO `auth_permission` VALUES (70, 'Can change 城市', 18, 'change_city');
INSERT INTO `auth_permission` VALUES (71, 'Can delete 城市', 18, 'delete_city');
INSERT INTO `auth_permission` VALUES (72, 'Can view 城市', 18, 'view_city');
INSERT INTO `auth_permission` VALUES (73, 'Can add 热门城市', 19, 'add_hotcity');
INSERT INTO `auth_permission` VALUES (74, 'Can change 热门城市', 19, 'change_hotcity');
INSERT INTO `auth_permission` VALUES (75, 'Can delete 热门城市', 19, 'delete_hotcity');
INSERT INTO `auth_permission` VALUES (76, 'Can view 热门城市', 19, 'view_hotcity');
INSERT INTO `auth_permission` VALUES (77, 'Can add 省份', 20, 'add_province');
INSERT INTO `auth_permission` VALUES (78, 'Can change 省份', 20, 'change_province');
INSERT INTO `auth_permission` VALUES (79, 'Can delete 省份', 20, 'delete_province');
INSERT INTO `auth_permission` VALUES (80, 'Can view 省份', 20, 'view_province');
INSERT INTO `auth_permission` VALUES (81, 'Can add 收藏职位', 21, 'add_submitresume');
INSERT INTO `auth_permission` VALUES (82, 'Can change 收藏职位', 21, 'change_submitresume');
INSERT INTO `auth_permission` VALUES (83, 'Can delete 收藏职位', 21, 'delete_submitresume');
INSERT INTO `auth_permission` VALUES (84, 'Can view 收藏职位', 21, 'view_submitresume');
INSERT INTO `auth_permission` VALUES (85, 'Can add 用户登录账户信息', 22, 'add_user');
INSERT INTO `auth_permission` VALUES (86, 'Can change 用户登录账户信息', 22, 'change_user');
INSERT INTO `auth_permission` VALUES (87, 'Can delete 用户登录账户信息', 22, 'delete_user');
INSERT INTO `auth_permission` VALUES (88, 'Can view 用户登录账户信息', 22, 'view_user');
INSERT INTO `auth_permission` VALUES (89, 'Can add 教育经历', 23, 'add_educationalexperience');
INSERT INTO `auth_permission` VALUES (90, 'Can change 教育经历', 23, 'change_educationalexperience');
INSERT INTO `auth_permission` VALUES (91, 'Can delete 教育经历', 23, 'delete_educationalexperience');
INSERT INTO `auth_permission` VALUES (92, 'Can view 教育经历', 23, 'view_educationalexperience');
INSERT INTO `auth_permission` VALUES (93, 'Can add 作品展示', 24, 'add_gallery');
INSERT INTO `auth_permission` VALUES (94, 'Can change 作品展示', 24, 'change_gallery');
INSERT INTO `auth_permission` VALUES (95, 'Can delete 作品展示', 24, 'delete_gallery');
INSERT INTO `auth_permission` VALUES (96, 'Can view 作品展示', 24, 'view_gallery');
INSERT INTO `auth_permission` VALUES (97, 'Can add 期望工作', 25, 'add_hopework');
INSERT INTO `auth_permission` VALUES (98, 'Can change 期望工作', 25, 'change_hopework');
INSERT INTO `auth_permission` VALUES (99, 'Can delete 期望工作', 25, 'delete_hopework');
INSERT INTO `auth_permission` VALUES (100, 'Can view 期望工作', 25, 'view_hopework');
INSERT INTO `auth_permission` VALUES (101, 'Can add 收藏职位', 26, 'add_positioncollection');
INSERT INTO `auth_permission` VALUES (102, 'Can change 收藏职位', 26, 'change_positioncollection');
INSERT INTO `auth_permission` VALUES (103, 'Can delete 收藏职位', 26, 'delete_positioncollection');
INSERT INTO `auth_permission` VALUES (104, 'Can view 收藏职位', 26, 'view_positioncollection');
INSERT INTO `auth_permission` VALUES (105, 'Can add 项目经验', 27, 'add_projectexperience');
INSERT INTO `auth_permission` VALUES (106, 'Can change 项目经验', 27, 'change_projectexperience');
INSERT INTO `auth_permission` VALUES (107, 'Can delete 项目经验', 27, 'delete_projectexperience');
INSERT INTO `auth_permission` VALUES (108, 'Can view 项目经验', 27, 'view_projectexperience');
INSERT INTO `auth_permission` VALUES (109, 'Can add 简历信息', 28, 'add_resume');
INSERT INTO `auth_permission` VALUES (110, 'Can change 简历信息', 28, 'change_resume');
INSERT INTO `auth_permission` VALUES (111, 'Can delete 简历信息', 28, 'delete_resume');
INSERT INTO `auth_permission` VALUES (112, 'Can view 简历信息', 28, 'view_resume');
INSERT INTO `auth_permission` VALUES (113, 'Can add 附件简历', 29, 'add_resumefile');
INSERT INTO `auth_permission` VALUES (114, 'Can change 附件简历', 29, 'change_resumefile');
INSERT INTO `auth_permission` VALUES (115, 'Can delete 附件简历', 29, 'delete_resumefile');
INSERT INTO `auth_permission` VALUES (116, 'Can view 附件简历', 29, 'view_resumefile');
INSERT INTO `auth_permission` VALUES (117, 'Can add 基本信息', 30, 'add_resumeinfo');
INSERT INTO `auth_permission` VALUES (118, 'Can change 基本信息', 30, 'change_resumeinfo');
INSERT INTO `auth_permission` VALUES (119, 'Can delete 基本信息', 30, 'delete_resumeinfo');
INSERT INTO `auth_permission` VALUES (120, 'Can view 基本信息', 30, 'view_resumeinfo');
INSERT INTO `auth_permission` VALUES (121, 'Can add 自我描述', 31, 'add_selfdetail');
INSERT INTO `auth_permission` VALUES (122, 'Can change 自我描述', 31, 'change_selfdetail');
INSERT INTO `auth_permission` VALUES (123, 'Can delete 自我描述', 31, 'delete_selfdetail');
INSERT INTO `auth_permission` VALUES (124, 'Can view 自我描述', 31, 'view_selfdetail');
INSERT INTO `auth_permission` VALUES (125, 'Can add 订阅信息', 32, 'add_subscription');
INSERT INTO `auth_permission` VALUES (126, 'Can change 订阅信息', 32, 'change_subscription');
INSERT INTO `auth_permission` VALUES (127, 'Can delete 订阅信息', 32, 'delete_subscription');
INSERT INTO `auth_permission` VALUES (128, 'Can view 订阅信息', 32, 'view_subscription');
INSERT INTO `auth_permission` VALUES (129, 'Can add 工作经历', 33, 'add_workexperience');
INSERT INTO `auth_permission` VALUES (130, 'Can change 工作经历', 33, 'change_workexperience');
INSERT INTO `auth_permission` VALUES (131, 'Can delete 工作经历', 33, 'delete_workexperience');
INSERT INTO `auth_permission` VALUES (132, 'Can view 工作经历', 33, 'view_workexperience');

-- ----------------------------
-- Table structure for auth_user
-- ----------------------------
DROP TABLE IF EXISTS `auth_user`;
CREATE TABLE `auth_user`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `password` varchar(128) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `last_login` datetime(6) NULL DEFAULT NULL,
  `is_superuser` tinyint(1) NOT NULL,
  `username` varchar(150) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `first_name` varchar(30) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `last_name` varchar(150) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `email` varchar(254) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `is_staff` tinyint(1) NOT NULL,
  `is_active` tinyint(1) NOT NULL,
  `date_joined` datetime(6) NULL,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `username`(`username`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 2 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of auth_user
-- ----------------------------
INSERT INTO `auth_user` VALUES (1, 'pbkdf2_sha256$120000$cQMwm3Yxos5a$3I7/wV0pE2rOVtiXSO9SBy2u7NYfqXHtOqRCaFtbtLM=', '2019-04-27 14:48:18.511971', 1, 'admin', '', '', '123@123.com', 1, 1, '2019-04-20 14:34:17.214751');

-- ----------------------------
-- Table structure for auth_user_groups
-- ----------------------------
DROP TABLE IF EXISTS `auth_user_groups`;
CREATE TABLE `auth_user_groups`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) NOT NULL,
  `group_id` int(11) NOT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `auth_user_groups_user_id_group_id_94350c0c_uniq`(`user_id`, `group_id`) USING BTREE,
  INDEX `auth_user_groups_group_id_97559544_fk_auth_group_id`(`group_id`) USING BTREE,
  CONSTRAINT `auth_user_groups_group_id_97559544_fk_auth_group_id` FOREIGN KEY (`group_id`) REFERENCES `auth_group` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `auth_user_groups_user_id_6a12ed8b_fk_auth_user_id` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for auth_user_user_permissions
-- ----------------------------
DROP TABLE IF EXISTS `auth_user_user_permissions`;
CREATE TABLE `auth_user_user_permissions`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) NOT NULL,
  `permission_id` int(11) NOT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `auth_user_user_permissions_user_id_permission_id_14a6b632_uniq`(`user_id`, `permission_id`) USING BTREE,
  INDEX `auth_user_user_permi_permission_id_1fbb5f2c_fk_auth_perm`(`permission_id`) USING BTREE,
  CONSTRAINT `auth_user_user_permi_permission_id_1fbb5f2c_fk_auth_perm` FOREIGN KEY (`permission_id`) REFERENCES `auth_permission` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `auth_user_user_permissions_user_id_a95ead1b_fk_auth_user_id` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for common_banner
-- ----------------------------
DROP TABLE IF EXISTS `common_banner`;
CREATE TABLE `common_banner`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `img` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `url` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `alt` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `level` int(11) NOT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 4 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of common_banner
-- ----------------------------
INSERT INTO `common_banner` VALUES (1, 'banner/g_3.jpg', '', '跳槽！冲刺年薪1000000！', 0);
INSERT INTO `common_banner` VALUES (2, 'banner/g_4.jpg', '', '出北京记', 0);
INSERT INTO `common_banner` VALUES (3, 'banner/g_5.jpg', 'https://github.com/WPN0837', '看球就放假', 0);

-- ----------------------------
-- Table structure for common_city
-- ----------------------------
DROP TABLE IF EXISTS `common_city`;
CREATE TABLE `common_city`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `province_id` int(11) NOT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `common_city_province_id_78191348_fk_common_province_id`(`province_id`) USING BTREE,
  CONSTRAINT `common_city_province_id_78191348_fk_common_province_id` FOREIGN KEY (`province_id`) REFERENCES `common_province` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 377 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of common_city
-- ----------------------------
INSERT INTO `common_city` VALUES (1, '北京', 1);
INSERT INTO `common_city` VALUES (2, '天津', 2);
INSERT INTO `common_city` VALUES (3, '石家庄', 3);
INSERT INTO `common_city` VALUES (4, '唐山', 3);
INSERT INTO `common_city` VALUES (5, '秦皇岛', 3);
INSERT INTO `common_city` VALUES (6, '邯郸', 3);
INSERT INTO `common_city` VALUES (7, '邢台', 3);
INSERT INTO `common_city` VALUES (8, '雄安新区', 3);
INSERT INTO `common_city` VALUES (9, '保定', 3);
INSERT INTO `common_city` VALUES (10, '张家口', 3);
INSERT INTO `common_city` VALUES (11, '承德', 3);
INSERT INTO `common_city` VALUES (12, '沧州', 3);
INSERT INTO `common_city` VALUES (13, '廊坊', 3);
INSERT INTO `common_city` VALUES (14, '衡水', 3);
INSERT INTO `common_city` VALUES (15, '太原', 4);
INSERT INTO `common_city` VALUES (16, '大同', 4);
INSERT INTO `common_city` VALUES (17, '阳泉', 4);
INSERT INTO `common_city` VALUES (18, '长治', 4);
INSERT INTO `common_city` VALUES (19, '晋城', 4);
INSERT INTO `common_city` VALUES (20, '朔州', 4);
INSERT INTO `common_city` VALUES (21, '晋中', 4);
INSERT INTO `common_city` VALUES (22, '运城', 4);
INSERT INTO `common_city` VALUES (23, '忻州', 4);
INSERT INTO `common_city` VALUES (24, '临汾', 4);
INSERT INTO `common_city` VALUES (25, '吕梁', 4);
INSERT INTO `common_city` VALUES (26, '呼和浩特', 5);
INSERT INTO `common_city` VALUES (27, '包头', 5);
INSERT INTO `common_city` VALUES (28, '乌海', 5);
INSERT INTO `common_city` VALUES (29, '赤峰', 5);
INSERT INTO `common_city` VALUES (30, '通辽', 5);
INSERT INTO `common_city` VALUES (31, '鄂尔多斯', 5);
INSERT INTO `common_city` VALUES (32, '呼伦贝尔', 5);
INSERT INTO `common_city` VALUES (33, '巴彦淖尔', 5);
INSERT INTO `common_city` VALUES (34, '乌兰察布', 5);
INSERT INTO `common_city` VALUES (35, '兴安盟', 5);
INSERT INTO `common_city` VALUES (36, '锡林郭勒盟', 5);
INSERT INTO `common_city` VALUES (37, '阿拉善盟', 5);
INSERT INTO `common_city` VALUES (38, '沈阳', 6);
INSERT INTO `common_city` VALUES (39, '大连', 6);
INSERT INTO `common_city` VALUES (40, '鞍山', 6);
INSERT INTO `common_city` VALUES (41, '抚顺', 6);
INSERT INTO `common_city` VALUES (42, '本溪', 6);
INSERT INTO `common_city` VALUES (43, '丹东', 6);
INSERT INTO `common_city` VALUES (44, '锦州', 6);
INSERT INTO `common_city` VALUES (45, '营口', 6);
INSERT INTO `common_city` VALUES (46, '阜新', 6);
INSERT INTO `common_city` VALUES (47, '辽阳', 6);
INSERT INTO `common_city` VALUES (48, '盘锦', 6);
INSERT INTO `common_city` VALUES (49, '铁岭', 6);
INSERT INTO `common_city` VALUES (50, '朝阳', 6);
INSERT INTO `common_city` VALUES (51, '葫芦岛', 6);
INSERT INTO `common_city` VALUES (52, '长春', 7);
INSERT INTO `common_city` VALUES (53, '吉林', 7);
INSERT INTO `common_city` VALUES (54, '四平', 7);
INSERT INTO `common_city` VALUES (55, '辽源', 7);
INSERT INTO `common_city` VALUES (56, '通化', 7);
INSERT INTO `common_city` VALUES (57, '白山', 7);
INSERT INTO `common_city` VALUES (58, '松原', 7);
INSERT INTO `common_city` VALUES (59, '白城', 7);
INSERT INTO `common_city` VALUES (60, '延边州', 7);
INSERT INTO `common_city` VALUES (61, '哈尔滨', 8);
INSERT INTO `common_city` VALUES (62, '齐齐哈尔', 8);
INSERT INTO `common_city` VALUES (63, '鸡西', 8);
INSERT INTO `common_city` VALUES (64, '鹤岗', 8);
INSERT INTO `common_city` VALUES (65, '双鸭山', 8);
INSERT INTO `common_city` VALUES (66, '大庆', 8);
INSERT INTO `common_city` VALUES (67, '伊春', 8);
INSERT INTO `common_city` VALUES (68, '佳木斯', 8);
INSERT INTO `common_city` VALUES (69, '七台河', 8);
INSERT INTO `common_city` VALUES (70, '牡丹江', 8);
INSERT INTO `common_city` VALUES (71, '黑河', 8);
INSERT INTO `common_city` VALUES (72, '绥化', 8);
INSERT INTO `common_city` VALUES (73, '大兴安岭', 8);
INSERT INTO `common_city` VALUES (74, '上海', 9);
INSERT INTO `common_city` VALUES (75, '南京', 10);
INSERT INTO `common_city` VALUES (76, '无锡', 10);
INSERT INTO `common_city` VALUES (77, '徐州', 10);
INSERT INTO `common_city` VALUES (78, '常州', 10);
INSERT INTO `common_city` VALUES (79, '苏州', 10);
INSERT INTO `common_city` VALUES (80, '南通', 10);
INSERT INTO `common_city` VALUES (81, '连云港', 10);
INSERT INTO `common_city` VALUES (82, '淮安', 10);
INSERT INTO `common_city` VALUES (83, '盐城', 10);
INSERT INTO `common_city` VALUES (84, '扬州', 10);
INSERT INTO `common_city` VALUES (85, '镇江', 10);
INSERT INTO `common_city` VALUES (86, '泰州', 10);
INSERT INTO `common_city` VALUES (87, '宿迁', 10);
INSERT INTO `common_city` VALUES (88, '杭州', 11);
INSERT INTO `common_city` VALUES (89, '宁波', 11);
INSERT INTO `common_city` VALUES (90, '温州', 11);
INSERT INTO `common_city` VALUES (91, '嘉兴', 11);
INSERT INTO `common_city` VALUES (92, '湖州', 11);
INSERT INTO `common_city` VALUES (93, '绍兴', 11);
INSERT INTO `common_city` VALUES (94, '金华', 11);
INSERT INTO `common_city` VALUES (95, '衢州', 11);
INSERT INTO `common_city` VALUES (96, '舟山', 11);
INSERT INTO `common_city` VALUES (97, '台州', 11);
INSERT INTO `common_city` VALUES (98, '丽水', 11);
INSERT INTO `common_city` VALUES (99, '合肥', 12);
INSERT INTO `common_city` VALUES (100, '芜湖', 12);
INSERT INTO `common_city` VALUES (101, '蚌埠', 12);
INSERT INTO `common_city` VALUES (102, '淮南', 12);
INSERT INTO `common_city` VALUES (103, '马鞍', 12);
INSERT INTO `common_city` VALUES (104, '淮北', 12);
INSERT INTO `common_city` VALUES (105, '铜陵', 12);
INSERT INTO `common_city` VALUES (106, '安庆', 12);
INSERT INTO `common_city` VALUES (107, '黄山', 12);
INSERT INTO `common_city` VALUES (108, '滁州', 12);
INSERT INTO `common_city` VALUES (109, '阜阳', 12);
INSERT INTO `common_city` VALUES (110, '宿州', 12);
INSERT INTO `common_city` VALUES (111, '六安', 12);
INSERT INTO `common_city` VALUES (112, '亳州', 12);
INSERT INTO `common_city` VALUES (113, '池州', 12);
INSERT INTO `common_city` VALUES (114, '宣城', 12);
INSERT INTO `common_city` VALUES (115, '福州', 13);
INSERT INTO `common_city` VALUES (116, '厦门', 13);
INSERT INTO `common_city` VALUES (117, '莆田', 13);
INSERT INTO `common_city` VALUES (118, '三明', 13);
INSERT INTO `common_city` VALUES (119, '泉州', 13);
INSERT INTO `common_city` VALUES (120, '漳州', 13);
INSERT INTO `common_city` VALUES (121, '南平', 13);
INSERT INTO `common_city` VALUES (122, '龙岩', 13);
INSERT INTO `common_city` VALUES (123, '宁德', 13);
INSERT INTO `common_city` VALUES (124, '南昌市', 14);
INSERT INTO `common_city` VALUES (125, '景德镇市', 14);
INSERT INTO `common_city` VALUES (126, '萍乡', 14);
INSERT INTO `common_city` VALUES (127, '九江', 14);
INSERT INTO `common_city` VALUES (128, '新余', 14);
INSERT INTO `common_city` VALUES (129, '鹰潭', 14);
INSERT INTO `common_city` VALUES (130, '赣州', 14);
INSERT INTO `common_city` VALUES (131, '吉安', 14);
INSERT INTO `common_city` VALUES (132, '宜春', 14);
INSERT INTO `common_city` VALUES (133, '抚州', 14);
INSERT INTO `common_city` VALUES (134, '上饶', 14);
INSERT INTO `common_city` VALUES (135, '济南', 15);
INSERT INTO `common_city` VALUES (136, '青岛', 15);
INSERT INTO `common_city` VALUES (137, '淄博', 15);
INSERT INTO `common_city` VALUES (138, '枣庄', 15);
INSERT INTO `common_city` VALUES (139, '东营', 15);
INSERT INTO `common_city` VALUES (140, '烟台', 15);
INSERT INTO `common_city` VALUES (141, '潍坊', 15);
INSERT INTO `common_city` VALUES (142, '济宁', 15);
INSERT INTO `common_city` VALUES (143, '泰安', 15);
INSERT INTO `common_city` VALUES (144, '威海', 15);
INSERT INTO `common_city` VALUES (145, '日照', 15);
INSERT INTO `common_city` VALUES (146, '临沂', 15);
INSERT INTO `common_city` VALUES (147, '德州', 15);
INSERT INTO `common_city` VALUES (148, '聊城', 15);
INSERT INTO `common_city` VALUES (149, '滨州', 15);
INSERT INTO `common_city` VALUES (150, '菏泽', 15);
INSERT INTO `common_city` VALUES (151, '郑州', 16);
INSERT INTO `common_city` VALUES (152, '开封', 16);
INSERT INTO `common_city` VALUES (153, '洛阳', 16);
INSERT INTO `common_city` VALUES (154, '平顶山', 16);
INSERT INTO `common_city` VALUES (155, '安阳', 16);
INSERT INTO `common_city` VALUES (156, '鹤壁', 16);
INSERT INTO `common_city` VALUES (157, '新乡', 16);
INSERT INTO `common_city` VALUES (158, '焦作', 16);
INSERT INTO `common_city` VALUES (159, '濮阳', 16);
INSERT INTO `common_city` VALUES (160, '许昌市', 16);
INSERT INTO `common_city` VALUES (161, '漯河', 16);
INSERT INTO `common_city` VALUES (162, '三门峡', 16);
INSERT INTO `common_city` VALUES (163, '南阳', 16);
INSERT INTO `common_city` VALUES (164, '商丘', 16);
INSERT INTO `common_city` VALUES (165, '信阳', 16);
INSERT INTO `common_city` VALUES (166, '周口', 16);
INSERT INTO `common_city` VALUES (167, '驻马店', 16);
INSERT INTO `common_city` VALUES (168, '济源', 16);
INSERT INTO `common_city` VALUES (169, '武汉', 17);
INSERT INTO `common_city` VALUES (170, '黄石', 17);
INSERT INTO `common_city` VALUES (171, '十堰', 17);
INSERT INTO `common_city` VALUES (172, '宜昌', 17);
INSERT INTO `common_city` VALUES (173, '襄阳', 17);
INSERT INTO `common_city` VALUES (174, '鄂州', 17);
INSERT INTO `common_city` VALUES (175, '荆门', 17);
INSERT INTO `common_city` VALUES (176, '孝感', 17);
INSERT INTO `common_city` VALUES (177, '荆州', 17);
INSERT INTO `common_city` VALUES (178, '黄冈', 17);
INSERT INTO `common_city` VALUES (179, '咸宁', 17);
INSERT INTO `common_city` VALUES (180, '随州', 17);
INSERT INTO `common_city` VALUES (181, '恩施州', 17);
INSERT INTO `common_city` VALUES (182, '仙桃', 17);
INSERT INTO `common_city` VALUES (183, '潜江', 17);
INSERT INTO `common_city` VALUES (184, '天门', 17);
INSERT INTO `common_city` VALUES (185, '神农架', 17);
INSERT INTO `common_city` VALUES (186, '长沙', 18);
INSERT INTO `common_city` VALUES (187, '株洲', 18);
INSERT INTO `common_city` VALUES (188, '湘潭', 18);
INSERT INTO `common_city` VALUES (189, '衡阳', 18);
INSERT INTO `common_city` VALUES (190, '邵阳', 18);
INSERT INTO `common_city` VALUES (191, '岳阳', 18);
INSERT INTO `common_city` VALUES (192, '常德', 18);
INSERT INTO `common_city` VALUES (193, '张家界', 18);
INSERT INTO `common_city` VALUES (194, '益阳', 18);
INSERT INTO `common_city` VALUES (195, '郴州', 18);
INSERT INTO `common_city` VALUES (196, '永州', 18);
INSERT INTO `common_city` VALUES (197, '怀化', 18);
INSERT INTO `common_city` VALUES (198, '娄底', 18);
INSERT INTO `common_city` VALUES (199, '湘西州', 18);
INSERT INTO `common_city` VALUES (200, '广州', 19);
INSERT INTO `common_city` VALUES (201, '韶关', 19);
INSERT INTO `common_city` VALUES (202, '深圳', 19);
INSERT INTO `common_city` VALUES (203, '珠海', 19);
INSERT INTO `common_city` VALUES (204, '汕头', 19);
INSERT INTO `common_city` VALUES (205, '佛山', 19);
INSERT INTO `common_city` VALUES (206, '江门', 19);
INSERT INTO `common_city` VALUES (207, '湛江', 19);
INSERT INTO `common_city` VALUES (208, '茂名', 19);
INSERT INTO `common_city` VALUES (209, '肇庆', 19);
INSERT INTO `common_city` VALUES (210, '惠州', 19);
INSERT INTO `common_city` VALUES (211, '梅州', 19);
INSERT INTO `common_city` VALUES (212, '汕尾', 19);
INSERT INTO `common_city` VALUES (213, '河源', 19);
INSERT INTO `common_city` VALUES (214, '阳江', 19);
INSERT INTO `common_city` VALUES (215, '清远', 19);
INSERT INTO `common_city` VALUES (216, '东莞', 19);
INSERT INTO `common_city` VALUES (217, '中山', 19);
INSERT INTO `common_city` VALUES (218, '潮州', 19);
INSERT INTO `common_city` VALUES (219, '揭阳', 19);
INSERT INTO `common_city` VALUES (220, '云浮', 19);
INSERT INTO `common_city` VALUES (221, '南宁', 20);
INSERT INTO `common_city` VALUES (222, '柳州', 20);
INSERT INTO `common_city` VALUES (223, '桂林', 20);
INSERT INTO `common_city` VALUES (224, '梧州', 20);
INSERT INTO `common_city` VALUES (225, '北海', 20);
INSERT INTO `common_city` VALUES (226, '防城港', 20);
INSERT INTO `common_city` VALUES (227, '钦州', 20);
INSERT INTO `common_city` VALUES (228, '贵港', 20);
INSERT INTO `common_city` VALUES (229, '玉林', 20);
INSERT INTO `common_city` VALUES (230, '百色', 20);
INSERT INTO `common_city` VALUES (231, '贺州', 20);
INSERT INTO `common_city` VALUES (232, '河池', 20);
INSERT INTO `common_city` VALUES (233, '来宾', 20);
INSERT INTO `common_city` VALUES (234, '崇左', 20);
INSERT INTO `common_city` VALUES (235, '海口', 21);
INSERT INTO `common_city` VALUES (236, '三亚', 21);
INSERT INTO `common_city` VALUES (237, '五指山', 21);
INSERT INTO `common_city` VALUES (238, '琼海', 21);
INSERT INTO `common_city` VALUES (239, '儋州', 21);
INSERT INTO `common_city` VALUES (240, '文昌', 21);
INSERT INTO `common_city` VALUES (241, '万宁', 21);
INSERT INTO `common_city` VALUES (242, '东方', 21);
INSERT INTO `common_city` VALUES (243, '定安县', 21);
INSERT INTO `common_city` VALUES (244, '屯昌县', 21);
INSERT INTO `common_city` VALUES (245, '澄迈县', 21);
INSERT INTO `common_city` VALUES (246, '临高县', 21);
INSERT INTO `common_city` VALUES (247, '白沙县', 21);
INSERT INTO `common_city` VALUES (248, '昌江县', 21);
INSERT INTO `common_city` VALUES (249, '乐东县', 21);
INSERT INTO `common_city` VALUES (250, '陵水县', 21);
INSERT INTO `common_city` VALUES (251, '保亭县', 21);
INSERT INTO `common_city` VALUES (252, '琼中县', 21);
INSERT INTO `common_city` VALUES (253, '三沙市', 21);
INSERT INTO `common_city` VALUES (254, '重庆', 22);
INSERT INTO `common_city` VALUES (255, '成都', 23);
INSERT INTO `common_city` VALUES (256, '自贡', 23);
INSERT INTO `common_city` VALUES (257, '攀枝花', 23);
INSERT INTO `common_city` VALUES (258, '泸州', 23);
INSERT INTO `common_city` VALUES (259, '德阳', 23);
INSERT INTO `common_city` VALUES (260, '绵阳', 23);
INSERT INTO `common_city` VALUES (261, '广元', 23);
INSERT INTO `common_city` VALUES (262, '遂宁', 23);
INSERT INTO `common_city` VALUES (263, '内江', 23);
INSERT INTO `common_city` VALUES (264, '乐山', 23);
INSERT INTO `common_city` VALUES (265, '南充', 23);
INSERT INTO `common_city` VALUES (266, '眉山', 23);
INSERT INTO `common_city` VALUES (267, '宜宾', 23);
INSERT INTO `common_city` VALUES (268, '广安', 23);
INSERT INTO `common_city` VALUES (269, '达州', 23);
INSERT INTO `common_city` VALUES (270, '雅安', 23);
INSERT INTO `common_city` VALUES (271, '巴中', 23);
INSERT INTO `common_city` VALUES (272, '资阳', 23);
INSERT INTO `common_city` VALUES (273, '阿坝', 23);
INSERT INTO `common_city` VALUES (274, '甘孜', 23);
INSERT INTO `common_city` VALUES (275, '凉山州', 23);
INSERT INTO `common_city` VALUES (276, '贵阳', 24);
INSERT INTO `common_city` VALUES (277, '六盘水', 24);
INSERT INTO `common_city` VALUES (278, '遵义', 24);
INSERT INTO `common_city` VALUES (279, '安顺', 24);
INSERT INTO `common_city` VALUES (280, '毕节市', 24);
INSERT INTO `common_city` VALUES (281, '铜仁市', 24);
INSERT INTO `common_city` VALUES (282, '黔西南州', 24);
INSERT INTO `common_city` VALUES (283, '黔东南州', 24);
INSERT INTO `common_city` VALUES (284, '黔南州', 24);
INSERT INTO `common_city` VALUES (285, '昆明', 25);
INSERT INTO `common_city` VALUES (286, '曲靖', 25);
INSERT INTO `common_city` VALUES (287, '玉溪', 25);
INSERT INTO `common_city` VALUES (288, '保山', 25);
INSERT INTO `common_city` VALUES (289, '昭通', 25);
INSERT INTO `common_city` VALUES (290, '丽江', 25);
INSERT INTO `common_city` VALUES (291, '普洱', 25);
INSERT INTO `common_city` VALUES (292, '临沧', 25);
INSERT INTO `common_city` VALUES (293, '楚雄州', 25);
INSERT INTO `common_city` VALUES (294, '红河州', 25);
INSERT INTO `common_city` VALUES (295, '文山州', 25);
INSERT INTO `common_city` VALUES (296, '西双版纳州', 25);
INSERT INTO `common_city` VALUES (297, '大理州', 25);
INSERT INTO `common_city` VALUES (298, '德宏州', 25);
INSERT INTO `common_city` VALUES (299, '怒江州', 25);
INSERT INTO `common_city` VALUES (300, '迪庆州', 25);
INSERT INTO `common_city` VALUES (301, '拉萨', 26);
INSERT INTO `common_city` VALUES (302, '日喀则', 26);
INSERT INTO `common_city` VALUES (303, '昌都', 26);
INSERT INTO `common_city` VALUES (304, '林芝', 26);
INSERT INTO `common_city` VALUES (305, '山南', 26);
INSERT INTO `common_city` VALUES (306, '那曲', 26);
INSERT INTO `common_city` VALUES (307, '阿里', 26);
INSERT INTO `common_city` VALUES (308, '西安', 27);
INSERT INTO `common_city` VALUES (309, '铜川', 27);
INSERT INTO `common_city` VALUES (310, '宝鸡', 27);
INSERT INTO `common_city` VALUES (311, '咸阳', 27);
INSERT INTO `common_city` VALUES (312, '渭南', 27);
INSERT INTO `common_city` VALUES (313, '延安', 27);
INSERT INTO `common_city` VALUES (314, '汉中', 27);
INSERT INTO `common_city` VALUES (315, '榆林', 27);
INSERT INTO `common_city` VALUES (316, '安康', 27);
INSERT INTO `common_city` VALUES (317, '商洛', 27);
INSERT INTO `common_city` VALUES (318, '兰州', 28);
INSERT INTO `common_city` VALUES (319, '嘉峪', 28);
INSERT INTO `common_city` VALUES (320, '金昌', 28);
INSERT INTO `common_city` VALUES (321, '白银', 28);
INSERT INTO `common_city` VALUES (322, '天水', 28);
INSERT INTO `common_city` VALUES (323, '武威', 28);
INSERT INTO `common_city` VALUES (324, '张掖', 28);
INSERT INTO `common_city` VALUES (325, '平凉', 28);
INSERT INTO `common_city` VALUES (326, '酒泉', 28);
INSERT INTO `common_city` VALUES (327, '庆阳', 28);
INSERT INTO `common_city` VALUES (328, '定西', 28);
INSERT INTO `common_city` VALUES (329, '陇南', 28);
INSERT INTO `common_city` VALUES (330, '临夏州', 28);
INSERT INTO `common_city` VALUES (331, '甘南州', 28);
INSERT INTO `common_city` VALUES (332, '西宁', 29);
INSERT INTO `common_city` VALUES (333, '海东', 29);
INSERT INTO `common_city` VALUES (334, '海北州', 29);
INSERT INTO `common_city` VALUES (335, '黄南州', 29);
INSERT INTO `common_city` VALUES (336, '海南州', 29);
INSERT INTO `common_city` VALUES (337, '果洛州', 29);
INSERT INTO `common_city` VALUES (338, '玉树州', 29);
INSERT INTO `common_city` VALUES (339, '海西州', 29);
INSERT INTO `common_city` VALUES (340, '银川', 30);
INSERT INTO `common_city` VALUES (341, '石嘴山', 30);
INSERT INTO `common_city` VALUES (342, '吴忠', 30);
INSERT INTO `common_city` VALUES (343, '固原', 30);
INSERT INTO `common_city` VALUES (344, '中卫', 30);
INSERT INTO `common_city` VALUES (345, '乌鲁木齐', 31);
INSERT INTO `common_city` VALUES (346, '克拉玛依', 31);
INSERT INTO `common_city` VALUES (347, '吐鲁番', 31);
INSERT INTO `common_city` VALUES (348, '哈密市', 31);
INSERT INTO `common_city` VALUES (349, '昌吉州', 31);
INSERT INTO `common_city` VALUES (350, '博尔塔拉州', 31);
INSERT INTO `common_city` VALUES (351, '巴音郭楞州', 31);
INSERT INTO `common_city` VALUES (352, '阿克苏地区', 31);
INSERT INTO `common_city` VALUES (353, '克孜勒苏州', 31);
INSERT INTO `common_city` VALUES (354, '喀什地区', 31);
INSERT INTO `common_city` VALUES (355, '和田地区', 31);
INSERT INTO `common_city` VALUES (356, '伊犁州', 31);
INSERT INTO `common_city` VALUES (357, '塔城地区', 31);
INSERT INTO `common_city` VALUES (358, '阿勒泰地区', 31);
INSERT INTO `common_city` VALUES (359, '石河子', 31);
INSERT INTO `common_city` VALUES (360, '阿拉尔', 31);
INSERT INTO `common_city` VALUES (361, '图木舒克', 31);
INSERT INTO `common_city` VALUES (362, '五家渠', 31);
INSERT INTO `common_city` VALUES (363, '北屯', 31);
INSERT INTO `common_city` VALUES (364, '铁门关', 31);
INSERT INTO `common_city` VALUES (365, '双河', 31);
INSERT INTO `common_city` VALUES (366, '可克达拉', 31);
INSERT INTO `common_city` VALUES (367, '昆玉', 31);
INSERT INTO `common_city` VALUES (368, '新北', 32);
INSERT INTO `common_city` VALUES (369, '台北', 32);
INSERT INTO `common_city` VALUES (370, '南投县', 32);
INSERT INTO `common_city` VALUES (371, '台南县', 32);
INSERT INTO `common_city` VALUES (372, '嘉义县', 32);
INSERT INTO `common_city` VALUES (373, '台中市', 32);
INSERT INTO `common_city` VALUES (374, '高雄市', 32);
INSERT INTO `common_city` VALUES (375, '香港', 33);
INSERT INTO `common_city` VALUES (376, '澳门  ', 34);

-- ----------------------------
-- Table structure for common_hotcity
-- ----------------------------
DROP TABLE IF EXISTS `common_hotcity`;
CREATE TABLE `common_hotcity`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `first` varchar(1) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 49 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of common_hotcity
-- ----------------------------
INSERT INTO `common_hotcity` VALUES (1, '北京', 'B');
INSERT INTO `common_hotcity` VALUES (2, '长春', 'C');
INSERT INTO `common_hotcity` VALUES (3, '成都', 'C');
INSERT INTO `common_hotcity` VALUES (4, '重庆', 'C');
INSERT INTO `common_hotcity` VALUES (5, '长沙', 'C');
INSERT INTO `common_hotcity` VALUES (6, '常州', 'C');
INSERT INTO `common_hotcity` VALUES (7, '东莞', 'D');
INSERT INTO `common_hotcity` VALUES (8, '大连', 'D');
INSERT INTO `common_hotcity` VALUES (9, '佛山', 'F');
INSERT INTO `common_hotcity` VALUES (10, '佛山', 'F');
INSERT INTO `common_hotcity` VALUES (11, '福州', 'F');
INSERT INTO `common_hotcity` VALUES (12, '贵阳', 'G');
INSERT INTO `common_hotcity` VALUES (13, '广州', 'G');
INSERT INTO `common_hotcity` VALUES (14, '哈尔滨', 'H');
INSERT INTO `common_hotcity` VALUES (15, '合肥', 'H');
INSERT INTO `common_hotcity` VALUES (16, '海口', 'H');
INSERT INTO `common_hotcity` VALUES (17, '杭州', 'H');
INSERT INTO `common_hotcity` VALUES (18, '惠州', 'H');
INSERT INTO `common_hotcity` VALUES (19, '金华', 'J');
INSERT INTO `common_hotcity` VALUES (20, '济南', 'J');
INSERT INTO `common_hotcity` VALUES (21, '嘉兴', 'J');
INSERT INTO `common_hotcity` VALUES (22, '昆明', 'K');
INSERT INTO `common_hotcity` VALUES (23, '廊坊', 'L');
INSERT INTO `common_hotcity` VALUES (24, '宁波', 'N');
INSERT INTO `common_hotcity` VALUES (25, '南昌', 'N');
INSERT INTO `common_hotcity` VALUES (26, '南京', 'N');
INSERT INTO `common_hotcity` VALUES (27, '南宁', 'N');
INSERT INTO `common_hotcity` VALUES (28, '南通', 'N');
INSERT INTO `common_hotcity` VALUES (29, '青岛', 'Q');
INSERT INTO `common_hotcity` VALUES (30, '泉州', 'Q');
INSERT INTO `common_hotcity` VALUES (31, '上海', 'S');
INSERT INTO `common_hotcity` VALUES (32, '石家庄', 'S');
INSERT INTO `common_hotcity` VALUES (33, '绍兴', 'S');
INSERT INTO `common_hotcity` VALUES (34, '沈阳', 'S');
INSERT INTO `common_hotcity` VALUES (35, '深圳', 'S');
INSERT INTO `common_hotcity` VALUES (36, '苏州', 'S');
INSERT INTO `common_hotcity` VALUES (37, '天津', 'T');
INSERT INTO `common_hotcity` VALUES (38, '太原', 'T');
INSERT INTO `common_hotcity` VALUES (39, '台州', 'T');
INSERT INTO `common_hotcity` VALUES (40, '武汉', 'W');
INSERT INTO `common_hotcity` VALUES (41, '无锡', 'W');
INSERT INTO `common_hotcity` VALUES (42, '温州', 'W');
INSERT INTO `common_hotcity` VALUES (43, '西安', 'X');
INSERT INTO `common_hotcity` VALUES (44, '厦门', 'X');
INSERT INTO `common_hotcity` VALUES (45, '烟台', 'Y');
INSERT INTO `common_hotcity` VALUES (46, '珠海', 'Z');
INSERT INTO `common_hotcity` VALUES (47, '中山', 'Z');
INSERT INTO `common_hotcity` VALUES (48, '郑州', 'Z');

-- ----------------------------
-- Table structure for common_province
-- ----------------------------
DROP TABLE IF EXISTS `common_province`;
CREATE TABLE `common_province`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 35 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of common_province
-- ----------------------------
INSERT INTO `common_province` VALUES (1, '北京');
INSERT INTO `common_province` VALUES (2, '天津');
INSERT INTO `common_province` VALUES (3, '河北');
INSERT INTO `common_province` VALUES (4, '山西');
INSERT INTO `common_province` VALUES (5, '内蒙古');
INSERT INTO `common_province` VALUES (6, '辽宁');
INSERT INTO `common_province` VALUES (7, '吉林');
INSERT INTO `common_province` VALUES (8, '黑龙江');
INSERT INTO `common_province` VALUES (9, '上海');
INSERT INTO `common_province` VALUES (10, '江苏');
INSERT INTO `common_province` VALUES (11, '浙江省');
INSERT INTO `common_province` VALUES (12, '安徽');
INSERT INTO `common_province` VALUES (13, '福建');
INSERT INTO `common_province` VALUES (14, '江西');
INSERT INTO `common_province` VALUES (15, '山东');
INSERT INTO `common_province` VALUES (16, '河南');
INSERT INTO `common_province` VALUES (17, '湖北');
INSERT INTO `common_province` VALUES (18, '湖南');
INSERT INTO `common_province` VALUES (19, '广东');
INSERT INTO `common_province` VALUES (20, '广西');
INSERT INTO `common_province` VALUES (21, '海南');
INSERT INTO `common_province` VALUES (22, '重庆');
INSERT INTO `common_province` VALUES (23, '四川');
INSERT INTO `common_province` VALUES (24, '贵州');
INSERT INTO `common_province` VALUES (25, '云南');
INSERT INTO `common_province` VALUES (26, '西藏');
INSERT INTO `common_province` VALUES (27, '陕西');
INSERT INTO `common_province` VALUES (28, '甘肃省');
INSERT INTO `common_province` VALUES (29, '青海');
INSERT INTO `common_province` VALUES (30, '宁夏');
INSERT INTO `common_province` VALUES (31, '新疆');
INSERT INTO `common_province` VALUES (32, '台湾');
INSERT INTO `common_province` VALUES (33, '香港特别行政区');
INSERT INTO `common_province` VALUES (34, '澳门');

-- ----------------------------
-- Table structure for common_submitresume
-- ----------------------------
DROP TABLE IF EXISTS `common_submitresume`;
CREATE TABLE `common_submitresume`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `add_time` datetime(6) NULL,
  `status` smallint(6) NOT NULL,
  `sort` smallint(6) NOT NULL,
  `delete` smallint(6) NOT NULL,
  `offer` smallint(6) NOT NULL,
  `position_id` int(11) NOT NULL,
  `resume_id` int(11) NOT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `common_submitresume_resume_id_position_id_317c2c0e_uniq`(`resume_id`, `position_id`) USING BTREE,
  INDEX `common_submitresume_position_id_0189307e_fk_Recruitme`(`position_id`) USING BTREE,
  CONSTRAINT `common_submitresume_position_id_0189307e_fk_Recruitme` FOREIGN KEY (`position_id`) REFERENCES `recruitment_positioninfo` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `common_submitresume_resume_id_52000ed5_fk_JobHunting_resume_id` FOREIGN KEY (`resume_id`) REFERENCES `jobhunting_resume` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 4 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of common_submitresume
-- ----------------------------
INSERT INTO `common_submitresume` VALUES (1, '2019-04-20 17:48:48.311244', 0, 1, 1, 0, 6, 1);
INSERT INTO `common_submitresume` VALUES (3, '2019-04-20 19:07:23.868478', 0, 1, 1, 1, 7, 1);

-- ----------------------------
-- Table structure for common_user
-- ----------------------------
DROP TABLE IF EXISTS `common_user`;
CREATE TABLE `common_user`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `email` varchar(254) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `pwd` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `type` smallint(6) NOT NULL,
  `activation` smallint(6) NOT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `email`(`email`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 18 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of common_user
-- ----------------------------
INSERT INTO `common_user` VALUES (1, '1905329584@qq.com', 'd4ff2650ea2ceb1fce36253d0817c537', 1, 1);
INSERT INTO `common_user` VALUES (2, '1302982067@qq.com', 'd4ff2650ea2ceb1fce36253d0817c537', 1, 1);
INSERT INTO `common_user` VALUES (3, '1183336596@qq.com', 'd4ff2650ea2ceb1fce36253d0817c537', 1, 1);
INSERT INTO `common_user` VALUES (4, '1131727441@qq.com', 'd4ff2650ea2ceb1fce36253d0817c537', 1, 1);
INSERT INTO `common_user` VALUES (5, '1347152542@qq.com', 'd4ff2650ea2ceb1fce36253d0817c537', 1, 1);
INSERT INTO `common_user` VALUES (6, '1174188994@qq.com', 'd4ff2650ea2ceb1fce36253d0817c537', 1, 1);
INSERT INTO `common_user` VALUES (7, 'douzhenghai97@qq.com', 'd4ff2650ea2ceb1fce36253d0817c537', 1, 1);
INSERT INTO `common_user` VALUES (8, '154167769@qq.com', 'd4ff2650ea2ceb1fce36253d0817c537', 0, 1);
INSERT INTO `common_user` VALUES (9, '894149432@qq.com', 'd4ff2650ea2ceb1fce36253d0817c537', 1, 1);
INSERT INTO `common_user` VALUES (10, 'lizi_i@qq.com', 'd4ff2650ea2ceb1fce36253d0817c537', 1, 1);
INSERT INTO `common_user` VALUES (11, '1234567@qq.com', 'd4ff2650ea2ceb1fce36253d0817c537', 1, 1);
INSERT INTO `common_user` VALUES (12, '1234568@qq.com', 'd4ff2650ea2ceb1fce36253d0817c537', 1, 1);
INSERT INTO `common_user` VALUES (13, '1234569@qq.com', 'd4ff2650ea2ceb1fce36253d0817c537', 1, 1);
INSERT INTO `common_user` VALUES (14, '1234560@qq.com', 'd4ff2650ea2ceb1fce36253d0817c537', 1, 1);
INSERT INTO `common_user` VALUES (15, '1234561@qq.com', 'd4ff2650ea2ceb1fce36253d0817c537', 1, 1);
INSERT INTO `common_user` VALUES (16, '1234562@qq.com', 'd4ff2650ea2ceb1fce36253d0817c537', 1, 1);
INSERT INTO `common_user` VALUES (17, '1234563@qq.com', 'd4ff2650ea2ceb1fce36253d0817c537', 1, 1);

-- ----------------------------
-- Table structure for django_admin_log
-- ----------------------------
DROP TABLE IF EXISTS `django_admin_log`;
CREATE TABLE `django_admin_log`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `action_time` datetime(6) NULL,
  `object_id` longtext CHARACTER SET utf8 COLLATE utf8_general_ci NULL,
  `object_repr` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `action_flag` smallint(5) UNSIGNED NOT NULL,
  `change_message` longtext CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `content_type_id` int(11) NULL DEFAULT NULL,
  `user_id` int(11) NOT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `django_admin_log_content_type_id_c4bce8eb_fk_django_co`(`content_type_id`) USING BTREE,
  INDEX `django_admin_log_user_id_c564eba6_fk_auth_user_id`(`user_id`) USING BTREE,
  CONSTRAINT `django_admin_log_content_type_id_c4bce8eb_fk_django_co` FOREIGN KEY (`content_type_id`) REFERENCES `django_content_type` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `django_admin_log_user_id_c564eba6_fk_auth_user_id` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 11 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of django_admin_log
-- ----------------------------
INSERT INTO `django_admin_log` VALUES (1, '2019-04-20 15:43:29.121690', '1', '跳槽！冲刺年薪1000000！', 1, '[{\"added\": {}}]', 17, 1);
INSERT INTO `django_admin_log` VALUES (2, '2019-04-20 15:44:12.616094', '2', '出北京记', 1, '[{\"added\": {}}]', 17, 1);
INSERT INTO `django_admin_log` VALUES (3, '2019-04-20 15:44:40.827569', '3', '看球就放假', 1, '[{\"added\": {}}]', 17, 1);
INSERT INTO `django_admin_log` VALUES (4, '2019-04-20 21:35:52.790491', '1', '蘑菇街', 2, '[{\"changed\": {\"fields\": [\"file_path\", \"status\"]}}]', 8, 1);
INSERT INTO `django_admin_log` VALUES (5, '2019-04-20 21:35:57.423932', '1', '蘑菇街', 2, '[{\"changed\": {\"fields\": [\"status\"]}}]', 8, 1);
INSERT INTO `django_admin_log` VALUES (6, '2019-04-27 13:16:01.447821', '2', '携程', 2, '[{\"changed\": {\"fields\": [\"file_path\", \"status\"]}}]', 8, 1);
INSERT INTO `django_admin_log` VALUES (7, '2019-04-27 13:31:33.230552', '2', '携程', 2, '[{\"changed\": {\"fields\": [\"status\"]}}]', 8, 1);
INSERT INTO `django_admin_log` VALUES (8, '2019-04-27 13:46:31.191089', '8', '携程网络科技有限公司', 2, '[{\"changed\": {\"fields\": [\"level\"]}}]', 7, 1);
INSERT INTO `django_admin_log` VALUES (9, '2019-04-27 14:30:58.551226', '3', '看球就放假', 2, '[{\"changed\": {\"fields\": [\"url\"]}}]', 17, 1);
INSERT INTO `django_admin_log` VALUES (10, '2019-04-27 15:02:16.151176', '16', 'Python', 2, '[{\"changed\": {\"fields\": [\"hot\"]}}]', 14, 1);

-- ----------------------------
-- Table structure for django_content_type
-- ----------------------------
DROP TABLE IF EXISTS `django_content_type`;
CREATE TABLE `django_content_type`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `app_label` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `model` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `django_content_type_app_label_model_76bd3d3b_uniq`(`app_label`, `model`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 34 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of django_content_type
-- ----------------------------
INSERT INTO `django_content_type` VALUES (1, 'admin', 'logentry');
INSERT INTO `django_content_type` VALUES (3, 'auth', 'group');
INSERT INTO `django_content_type` VALUES (2, 'auth', 'permission');
INSERT INTO `django_content_type` VALUES (4, 'auth', 'user');
INSERT INTO `django_content_type` VALUES (17, 'common', 'banner');
INSERT INTO `django_content_type` VALUES (18, 'common', 'city');
INSERT INTO `django_content_type` VALUES (19, 'common', 'hotcity');
INSERT INTO `django_content_type` VALUES (20, 'common', 'province');
INSERT INTO `django_content_type` VALUES (21, 'common', 'submitresume');
INSERT INTO `django_content_type` VALUES (22, 'common', 'user');
INSERT INTO `django_content_type` VALUES (5, 'contenttypes', 'contenttype');
INSERT INTO `django_content_type` VALUES (23, 'JobHunting', 'educationalexperience');
INSERT INTO `django_content_type` VALUES (24, 'JobHunting', 'gallery');
INSERT INTO `django_content_type` VALUES (25, 'JobHunting', 'hopework');
INSERT INTO `django_content_type` VALUES (26, 'JobHunting', 'positioncollection');
INSERT INTO `django_content_type` VALUES (27, 'JobHunting', 'projectexperience');
INSERT INTO `django_content_type` VALUES (28, 'JobHunting', 'resume');
INSERT INTO `django_content_type` VALUES (29, 'JobHunting', 'resumefile');
INSERT INTO `django_content_type` VALUES (30, 'JobHunting', 'resumeinfo');
INSERT INTO `django_content_type` VALUES (31, 'JobHunting', 'selfdetail');
INSERT INTO `django_content_type` VALUES (32, 'JobHunting', 'subscription');
INSERT INTO `django_content_type` VALUES (33, 'JobHunting', 'workexperience');
INSERT INTO `django_content_type` VALUES (7, 'Recruitment', 'company');
INSERT INTO `django_content_type` VALUES (8, 'Recruitment', 'companyauthfile');
INSERT INTO `django_content_type` VALUES (9, 'Recruitment', 'companyfoundingteam');
INSERT INTO `django_content_type` VALUES (10, 'Recruitment', 'companyintroduction');
INSERT INTO `django_content_type` VALUES (11, 'Recruitment', 'companyproduct');
INSERT INTO `django_content_type` VALUES (12, 'Recruitment', 'companytag');
INSERT INTO `django_content_type` VALUES (13, 'Recruitment', 'industrysector');
INSERT INTO `django_content_type` VALUES (14, 'Recruitment', 'position');
INSERT INTO `django_content_type` VALUES (15, 'Recruitment', 'positioninfo');
INSERT INTO `django_content_type` VALUES (16, 'Recruitment', 'tagsort');
INSERT INTO `django_content_type` VALUES (6, 'sessions', 'session');

-- ----------------------------
-- Table structure for django_migrations
-- ----------------------------
DROP TABLE IF EXISTS `django_migrations`;
CREATE TABLE `django_migrations`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `app` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `name` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `applied` datetime(6) NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 26 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of django_migrations
-- ----------------------------
INSERT INTO `django_migrations` VALUES (1, 'Recruitment', '0001_initial', '2019-04-20 14:33:39.900680');
INSERT INTO `django_migrations` VALUES (2, 'JobHunting', '0001_initial', '2019-04-20 14:33:40.545802');
INSERT INTO `django_migrations` VALUES (3, 'common', '0001_initial', '2019-04-20 14:33:41.272307');
INSERT INTO `django_migrations` VALUES (4, 'JobHunting', '0002_auto_20190420_1432', '2019-04-20 14:33:43.386168');
INSERT INTO `django_migrations` VALUES (5, 'Recruitment', '0002_company_user', '2019-04-20 14:33:43.619301');
INSERT INTO `django_migrations` VALUES (6, 'contenttypes', '0001_initial', '2019-04-20 14:33:43.730235');
INSERT INTO `django_migrations` VALUES (7, 'auth', '0001_initial', '2019-04-20 14:33:44.815936');
INSERT INTO `django_migrations` VALUES (8, 'admin', '0001_initial', '2019-04-20 14:33:45.094777');
INSERT INTO `django_migrations` VALUES (9, 'admin', '0002_logentry_remove_auto_add', '2019-04-20 14:33:45.117765');
INSERT INTO `django_migrations` VALUES (10, 'admin', '0003_logentry_add_action_flag_choices', '2019-04-20 14:33:45.143750');
INSERT INTO `django_migrations` VALUES (11, 'contenttypes', '0002_remove_content_type_name', '2019-04-20 14:33:45.406068');
INSERT INTO `django_migrations` VALUES (12, 'auth', '0002_alter_permission_name_max_length', '2019-04-20 14:33:45.533755');
INSERT INTO `django_migrations` VALUES (13, 'auth', '0003_alter_user_email_max_length', '2019-04-20 14:33:45.646819');
INSERT INTO `django_migrations` VALUES (14, 'auth', '0004_alter_user_username_opts', '2019-04-20 14:33:45.667807');
INSERT INTO `django_migrations` VALUES (15, 'auth', '0005_alter_user_last_login_null', '2019-04-20 14:33:45.741756');
INSERT INTO `django_migrations` VALUES (16, 'auth', '0006_require_contenttypes_0002', '2019-04-20 14:33:45.752729');
INSERT INTO `django_migrations` VALUES (17, 'auth', '0007_alter_validators_add_error_messages', '2019-04-20 14:33:45.774719');
INSERT INTO `django_migrations` VALUES (18, 'auth', '0008_alter_user_username_max_length', '2019-04-20 14:33:45.882679');
INSERT INTO `django_migrations` VALUES (19, 'auth', '0009_alter_user_last_name_max_length', '2019-04-20 14:33:45.993302');
INSERT INTO `django_migrations` VALUES (20, 'sessions', '0001_initial', '2019-04-20 14:33:46.077605');
INSERT INTO `django_migrations` VALUES (21, 'common', '0002_auto_20190420_1446', '2019-04-20 14:46:46.278040');
INSERT INTO `django_migrations` VALUES (22, 'Recruitment', '0003_companyauthfile_status', '2019-04-20 21:03:03.776250');
INSERT INTO `django_migrations` VALUES (23, 'Recruitment', '0004_auto_20190427_1317', '2019-04-27 13:17:45.748694');
INSERT INTO `django_migrations` VALUES (24, 'Recruitment', '0005_auto_20190427_1431', '2019-04-27 14:31:16.420607');
INSERT INTO `django_migrations` VALUES (25, 'common', '0003_auto_20190427_1431', '2019-04-27 14:31:16.531405');

-- ----------------------------
-- Table structure for django_session
-- ----------------------------
DROP TABLE IF EXISTS `django_session`;
CREATE TABLE `django_session`  (
  `session_key` varchar(40) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `session_data` longtext CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `expire_date` datetime(6) NULL,
  PRIMARY KEY (`session_key`) USING BTREE,
  INDEX `django_session_expire_date_a5c62663`(`expire_date`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of django_session
-- ----------------------------
INSERT INTO `django_session` VALUES ('av1auo52ng6xobpn96ufyf87v9s6gmtv', 'NjE1OWQwMjFiMmFiY2QwY2UwNmY5NjNhNGJmMmRmMmY2Y2MyYTJmYTp7ImNoZWNrX2NvZGUiOiJCZlNhIiwiX3Nlc3Npb25fZXhwaXJ5IjoyNTkyMDAwLCJlbWFpbCI6IjE1NDE2Nzc2OUBxcS5jb20ifQ==', '2019-05-22 19:33:24.045303');
INSERT INTO `django_session` VALUES ('cdllqqayaom01ag0oulmfr5znhaj56ig', 'ODk5ZGVjYWNiMzM2ODE2ZDQ3ZDllMTZiZTU5N2Q3ODRlZmNhNGY0Yjp7Il9hdXRoX3VzZXJfaWQiOiIxIiwiX2F1dGhfdXNlcl9iYWNrZW5kIjoiZGphbmdvLmNvbnRyaWIuYXV0aC5iYWNrZW5kcy5Nb2RlbEJhY2tlbmQiLCJfYXV0aF91c2VyX2hhc2giOiJjZTA5MjQwM2UxNTZjMWE4ZjE1YjQ0Y2ExMWJlYjgwNDZkNzQ3MDE3In0=', '2019-05-04 21:30:44.880597');
INSERT INTO `django_session` VALUES ('hyblrhiwiwt8bjqsw1w4xqxk4f0sygl5', 'ZTY1MjMxY2RjN2M2YWJhZDQ2M2E5Mjk4ZDIyNGFiNDA0ZDI2M2E1OTp7ImNoZWNrX2NvZGUiOiJtNXZQIn0=', '2019-05-09 15:52:23.458645');
INSERT INTO `django_session` VALUES ('n33lm7ajx3kdzdk7plhj65wrc7j2ktg0', 'MzI4NDcyMDg0ZTU3ODI0YzlkNjhjMGFhMjY2OTBlZGM3MDUzZWI2ODp7Il9zZXNzaW9uX2V4cGlyeSI6MH0=', '2019-05-11 16:43:06.355722');

-- ----------------------------
-- Table structure for jobhunting_educationalexperience
-- ----------------------------
DROP TABLE IF EXISTS `jobhunting_educationalexperience`;
CREATE TABLE `jobhunting_educationalexperience`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `school_name` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `education` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `professional` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `start_year` varchar(10) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `end_year` varchar(10) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `score` int(11) NOT NULL,
  `resume_id` int(11) NOT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `JobHunting_education_resume_id_bbcbd7a7_fk_JobHuntin`(`resume_id`) USING BTREE,
  CONSTRAINT `JobHunting_education_resume_id_bbcbd7a7_fk_JobHuntin` FOREIGN KEY (`resume_id`) REFERENCES `jobhunting_resume` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 2 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of jobhunting_educationalexperience
-- ----------------------------
INSERT INTO `jobhunting_educationalexperience` VALUES (1, '蚌埠学院', '本科', '软件工程', '2015', '2019', 15, 1);

-- ----------------------------
-- Table structure for jobhunting_gallery
-- ----------------------------
DROP TABLE IF EXISTS `jobhunting_gallery`;
CREATE TABLE `jobhunting_gallery`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `url` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `detail` varchar(500) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `score` int(11) NOT NULL,
  `resume_id` int(11) NOT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `JobHunting_gallery_resume_id_4cac4048_fk_JobHunting_resume_id`(`resume_id`) USING BTREE,
  CONSTRAINT `JobHunting_gallery_resume_id_4cac4048_fk_JobHunting_resume_id` FOREIGN KEY (`resume_id`) REFERENCES `jobhunting_resume` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 2 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of jobhunting_gallery
-- ----------------------------
INSERT INTO `jobhunting_gallery` VALUES (1, 'http://127.0.0.1:8000', '寻寻招聘', 15, 1);

-- ----------------------------
-- Table structure for jobhunting_hopework
-- ----------------------------
DROP TABLE IF EXISTS `jobhunting_hopework`;
CREATE TABLE `jobhunting_hopework`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `city` varchar(10) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `work_sort` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `hope_position` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `hope_wage` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `score` int(11) NOT NULL,
  `resume_id` int(11) NOT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `resume_id`(`resume_id`) USING BTREE,
  CONSTRAINT `JobHunting_hopework_resume_id_857cc4b9_fk_JobHunting_resume_id` FOREIGN KEY (`resume_id`) REFERENCES `jobhunting_resume` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 2 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of jobhunting_hopework
-- ----------------------------
INSERT INTO `jobhunting_hopework` VALUES (1, '上海', '全职', '产品运营', '2k-5k', 15, 1);

-- ----------------------------
-- Table structure for jobhunting_positioncollection
-- ----------------------------
DROP TABLE IF EXISTS `jobhunting_positioncollection`;
CREATE TABLE `jobhunting_positioncollection`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `add_time` datetime(6) NULL,
  `position_id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `JobHunting_positioncollection_user_id_position_id_81e513aa_uniq`(`user_id`, `position_id`) USING BTREE,
  INDEX `JobHunting_positionc_position_id_879b3bdf_fk_Recruitme`(`position_id`) USING BTREE,
  CONSTRAINT `JobHunting_positionc_position_id_879b3bdf_fk_Recruitme` FOREIGN KEY (`position_id`) REFERENCES `recruitment_positioninfo` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `JobHunting_positioncollection_user_id_b58852de_fk_common_user_id` FOREIGN KEY (`user_id`) REFERENCES `common_user` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 3 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of jobhunting_positioncollection
-- ----------------------------
INSERT INTO `jobhunting_positioncollection` VALUES (1, '2019-04-20 17:41:44.491673', 3, 8);
INSERT INTO `jobhunting_positioncollection` VALUES (2, '2019-04-20 17:42:05.246619', 5, 8);

-- ----------------------------
-- Table structure for jobhunting_projectexperience
-- ----------------------------
DROP TABLE IF EXISTS `jobhunting_projectexperience`;
CREATE TABLE `jobhunting_projectexperience`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `project_name` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `position` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `start_year` varchar(10) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `start_month` varchar(10) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `end_year` varchar(10) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `end_month` varchar(10) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `project_detail` varchar(500) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `score` int(11) NOT NULL,
  `resume_id` int(11) NOT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `JobHunting_projectex_resume_id_e3d6dc7c_fk_JobHuntin`(`resume_id`) USING BTREE,
  CONSTRAINT `JobHunting_projectex_resume_id_e3d6dc7c_fk_JobHuntin` FOREIGN KEY (`resume_id`) REFERENCES `jobhunting_resume` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 2 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of jobhunting_projectexperience
-- ----------------------------
INSERT INTO `jobhunting_projectexperience` VALUES (1, '飞机大战', '开发', '2017', '12', '2018', '01', '王思聪吃热狗之飞机大战', 15, 1);

-- ----------------------------
-- Table structure for jobhunting_resume
-- ----------------------------
DROP TABLE IF EXISTS `jobhunting_resume`;
CREATE TABLE `jobhunting_resume`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `title` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `last_time` datetime(6) NULL,
  `default` smallint(6) NULL DEFAULT NULL,
  `user_id` int(11) NOT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `user_id`(`user_id`) USING BTREE,
  CONSTRAINT `JobHunting_resume_user_id_80fad6c6_fk_common_user_id` FOREIGN KEY (`user_id`) REFERENCES `common_user` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 2 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of jobhunting_resume
-- ----------------------------
INSERT INTO `jobhunting_resume` VALUES (1, '寻寻的简历', '2019-04-20 17:41:25.018125', 1, 8);

-- ----------------------------
-- Table structure for jobhunting_resumefile
-- ----------------------------
DROP TABLE IF EXISTS `jobhunting_resumefile`;
CREATE TABLE `jobhunting_resumefile`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `resume_file` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `addTime` datetime(6) NULL,
  `resume_id` int(11) NOT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `resume_id`(`resume_id`) USING BTREE,
  CONSTRAINT `JobHunting_resumefile_resume_id_97a76540_fk_JobHunting_resume_id` FOREIGN KEY (`resume_id`) REFERENCES `jobhunting_resume` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for jobhunting_resumeinfo
-- ----------------------------
DROP TABLE IF EXISTS `jobhunting_resumeinfo`;
CREATE TABLE `jobhunting_resumeinfo`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `gender` varchar(2) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `education` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `work_ex` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `photo` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `phone` varchar(15) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `current_status` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `score` int(11) NOT NULL,
  `resume_id` int(11) NOT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `resume_id`(`resume_id`) USING BTREE,
  CONSTRAINT `JobHunting_resumeinfo_resume_id_6a1e0152_fk_JobHunting_resume_id` FOREIGN KEY (`resume_id`) REFERENCES `jobhunting_resume` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 2 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of jobhunting_resumeinfo
-- ----------------------------
INSERT INTO `jobhunting_resumeinfo` VALUES (1, '寻寻觅觅', '男', '本科', '应届毕业生', 'static/JobHunting/photo/2036eb28-6350-11e9-a505-b46d83399436123456.png', '18854214300', '我是应届毕业生', 15, 1);

-- ----------------------------
-- Table structure for jobhunting_selfdetail
-- ----------------------------
DROP TABLE IF EXISTS `jobhunting_selfdetail`;
CREATE TABLE `jobhunting_selfdetail`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `detail` varchar(500) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `score` int(11) NOT NULL,
  `resume_id` int(11) NOT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `resume_id`(`resume_id`) USING BTREE,
  CONSTRAINT `JobHunting_selfdetail_resume_id_4ad8d14b_fk_JobHunting_resume_id` FOREIGN KEY (`resume_id`) REFERENCES `jobhunting_resume` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for jobhunting_subscription
-- ----------------------------
DROP TABLE IF EXISTS `jobhunting_subscription`;
CREATE TABLE `jobhunting_subscription`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `email` varchar(254) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `cycle` int(11) NOT NULL,
  `city` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `finance_stage` varchar(5) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `industry_sector` varchar(5) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `position` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `salary` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `add_time` datetime(6) NULL,
  `user_id` int(11) NOT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `user_id`(`user_id`) USING BTREE,
  CONSTRAINT `JobHunting_subscription_user_id_f554c432_fk_common_user_id` FOREIGN KEY (`user_id`) REFERENCES `common_user` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 2 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of jobhunting_subscription
-- ----------------------------
INSERT INTO `jobhunting_subscription` VALUES (1, '154167769@qq.com', 7, '南京', '成长型', '移动互联网', 'C + +', '5k-10k', '2019-04-20 19:19:32.263275', 8);

-- ----------------------------
-- Table structure for jobhunting_workexperience
-- ----------------------------
DROP TABLE IF EXISTS `jobhunting_workexperience`;
CREATE TABLE `jobhunting_workexperience`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `company_name` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `position` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `start_year` varchar(10) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `start_month` varchar(10) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `end_year` varchar(10) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `end_month` varchar(10) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `score` int(11) NOT NULL,
  `resume_id` int(11) NOT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `JobHunting_workexper_resume_id_fc247476_fk_JobHuntin`(`resume_id`) USING BTREE,
  CONSTRAINT `JobHunting_workexper_resume_id_fc247476_fk_JobHuntin` FOREIGN KEY (`resume_id`) REFERENCES `jobhunting_resume` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for recruitment_company
-- ----------------------------
DROP TABLE IF EXISTS `recruitment_company`;
CREATE TABLE `recruitment_company`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `full_name` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `abbreviation_name` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `logo` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `url` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `city` varchar(10) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `scope` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `development_stage` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `desc` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `level` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `user_id`(`user_id`) USING BTREE,
  INDEX `Recruitment_company_full_name_62c0c6c8`(`full_name`) USING BTREE,
  INDEX `Recruitment_company_abbreviation_name_abb43188`(`abbreviation_name`) USING BTREE,
  INDEX `Recruitment_company_level_ab50c61b`(`level`) USING BTREE,
  CONSTRAINT `Recruitment_company_user_id_06a084fd_fk_common_user_id` FOREIGN KEY (`user_id`) REFERENCES `common_user` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 17 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of recruitment_company
-- ----------------------------
INSERT INTO `recruitment_company` VALUES (1, '中国国馆科技有限公司', '国馆', '/static/Company/logo/0a8bc1de-6339-11e9-a4ae-b46d83399436c (3).png', 'http://www.guoguan.com', '黄山', '2000人以上', '上市公司', '国之精粹，馆藏天下。', 0, 1);
INSERT INTO `recruitment_company` VALUES (2, '中国优酷视频科技公司', '优酷', '/static/Company/logo/0bdaf2c6-633b-11e9-8a87-b46d83399436c (1).png', 'http://www.youku.com', '北京', '500-2000人', '上市公司', '这世界很酷', 0, 2);
INSERT INTO `recruitment_company` VALUES (3, '中新大东方有限公司', '大东方', '/static/Company/logo/91ba550c-6340-11e9-816e-b46d83399436c (1).jpg', 'http://www.zxddf.com', '北京', '2000人以上', '上市公司', '健康人寿保险', 0, 3);
INSERT INTO `recruitment_company` VALUES (4, '中国蘑菇街网络商务科技有限公司', '蘑菇街', '/static/Company/logo/6e4e6eb8-6341-11e9-aade-b46d83399436c (2).jpg', 'http://www.mogujie.com', '上海', '150-500人', 'B轮', '蘑菇街，时尚至尚', 0, 4);
INSERT INTO `recruitment_company` VALUES (5, '暴走漫画新闻自媒体公司', '暴走漫画', '/static/Company/logo/9b375880-6342-11e9-a874-b46d83399436c (2).png', 'http://www.baozoumanhua.com', '上海', '150-500人', '未融资', '在拉轰界，王尼玛出书了！', 0, 5);
INSERT INTO `recruitment_company` VALUES (6, '搜狗科技有限公司', '搜狗', '/static/Company/logo/c876f224-6343-11e9-b973-b46d83399436c (3).jpg', 'http://www.sougou.com', '北京', '500-2000人', '上市公司', '他们搜狐， 搜狗输入法logo 搜狗输入法logo [6] 我们搜狗，各搜各的！', 0, 6);
INSERT INTO `recruitment_company` VALUES (7, '蓝鲸网络科技有限公司', '蓝鲸网络', '/static/Company/logo/ba981efe-6344-11e9-93a5-b46d83399436c (14).jpg', 'http://www.lanjing.com', '南京', '500-2000人', '上市公司', '蓝鲸不但是最大的鲸类，也是现存最大的动物', 0, 7);
INSERT INTO `recruitment_company` VALUES (8, '携程网络科技有限公司', '携程', '/static/Company/logo/2d1513ca-68aa-11e9-bcda-b46d83399436c (4).png', 'http://www.xiecheng.com', '北京', '500-2000人', '上市公司', '携程在手！！', 1, 9);
INSERT INTO `recruitment_company` VALUES (9, '淘米网络科技有限公司', '淘米网', '/static/Company/logo/f14d4c2e-68b7-11e9-94e5-b46d83399436c (9).jpg', 'http://www.61.com', '北京', '150-500人', 'C轮', 'tell me ', 0, 10);
INSERT INTO `recruitment_company` VALUES (10, '联想集团', '联想', '/static/Company/logo/47580a1c-68bf-11e9-9fa9-b46d83399436c (10).jpg', 'http://www.lenovo.com', '北京', '2000人以上', '上市公司', '联想，随你所想', 0, 11);
INSERT INTO `recruitment_company` VALUES (11, '韩国瓷肌化妆品有限公司', '瓷肌', '/static/Company/logo/950789e6-68c1-11e9-8444-b46d83399436c (11).jpg', 'http://www.ciji.com', '沈阳', '2000人以上', '上市公司', '韩国瓷肌发现，随着生活节奏加快，敏感、暗淡、粉刺等肌肤问题层出不穷，然而90%的人遇到皮肤问题时，面', 0, 12);
INSERT INTO `recruitment_company` VALUES (12, '堆糖', '堆糖', '/static/Company/logo/186ab91c-68c5-11e9-b3d1-b46d83399436c (8).jpg', 'http://www.duitang.com', '南宁', '少于15人', '未融资', '堆糖早期定位在有关物品的兴趣分享', 0, 13);
INSERT INTO `recruitment_company` VALUES (13, '北京思特奇信息技术股份有限公司', '思特奇', '/static/Company/logo/a066485a-68c5-11e9-9f75-b46d83399436c (12).jpg', 'http://www.siteqi.com', '北京', '500-2000人', 'C轮', '技术开发、技术转让、技术咨询', 0, 14);
INSERT INTO `recruitment_company` VALUES (14, '北京金棕榈企业策划有限公司', '金棕榈企业', '/static/Company/logo/30ab32ba-68c6-11e9-a8bb-b46d83399436c (6).png', 'http://www.global.com', '北京', '50-150人', '天使轮', '我们眼里的好创意不是创意人员的孤芳自赏', 0, 15);
INSERT INTO `recruitment_company` VALUES (15, '北京博雅恒辉咨询顾问有限公司', '博雅恒辉', '/static/Company/logo/d937023a-68c6-11e9-b88f-b46d83399436c (15).jpg', 'http://www.byhh.com', '北京', '15-50人', '未融资', '行业领军者', 0, 16);
INSERT INTO `recruitment_company` VALUES (16, '北京影合众新媒体技术服务有限公司', '乐影网', '/static/Company/logo/84b8f712-68c7-11e9-9f57-b46d83399436c (8).png', 'http://www.lemovie.com', '北京', '50-150人', '天使轮', '专注于电影行业的软件及互联网创业公司', 0, 17);

-- ----------------------------
-- Table structure for recruitment_company_industry_sector
-- ----------------------------
DROP TABLE IF EXISTS `recruitment_company_industry_sector`;
CREATE TABLE `recruitment_company_industry_sector`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `company_id` int(11) NOT NULL,
  `industrysector_id` int(11) NOT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `Recruitment_company_indu_company_id_industrysecto_0e7f5ccc_uniq`(`company_id`, `industrysector_id`) USING BTREE,
  INDEX `Recruitment_company__industrysector_id_32be0d1a_fk_Recruitme`(`industrysector_id`) USING BTREE,
  CONSTRAINT `Recruitment_company__company_id_2df0a8ce_fk_Recruitme` FOREIGN KEY (`company_id`) REFERENCES `recruitment_company` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `Recruitment_company__industrysector_id_32be0d1a_fk_Recruitme` FOREIGN KEY (`industrysector_id`) REFERENCES `recruitment_industrysector` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 33 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of recruitment_company_industry_sector
-- ----------------------------
INSERT INTO `recruitment_company_industry_sector` VALUES (1, 1, 2);
INSERT INTO `recruitment_company_industry_sector` VALUES (2, 1, 9);
INSERT INTO `recruitment_company_industry_sector` VALUES (3, 2, 1);
INSERT INTO `recruitment_company_industry_sector` VALUES (4, 2, 20);
INSERT INTO `recruitment_company_industry_sector` VALUES (5, 3, 10);
INSERT INTO `recruitment_company_industry_sector` VALUES (6, 3, 11);
INSERT INTO `recruitment_company_industry_sector` VALUES (7, 4, 2);
INSERT INTO `recruitment_company_industry_sector` VALUES (8, 4, 12);
INSERT INTO `recruitment_company_industry_sector` VALUES (9, 5, 20);
INSERT INTO `recruitment_company_industry_sector` VALUES (10, 5, 21);
INSERT INTO `recruitment_company_industry_sector` VALUES (11, 6, 1);
INSERT INTO `recruitment_company_industry_sector` VALUES (12, 6, 17);
INSERT INTO `recruitment_company_industry_sector` VALUES (13, 7, 1);
INSERT INTO `recruitment_company_industry_sector` VALUES (14, 7, 15);
INSERT INTO `recruitment_company_industry_sector` VALUES (15, 8, 1);
INSERT INTO `recruitment_company_industry_sector` VALUES (16, 8, 2);
INSERT INTO `recruitment_company_industry_sector` VALUES (17, 9, 2);
INSERT INTO `recruitment_company_industry_sector` VALUES (18, 9, 10);
INSERT INTO `recruitment_company_industry_sector` VALUES (19, 10, 2);
INSERT INTO `recruitment_company_industry_sector` VALUES (20, 10, 3);
INSERT INTO `recruitment_company_industry_sector` VALUES (21, 11, 2);
INSERT INTO `recruitment_company_industry_sector` VALUES (22, 11, 12);
INSERT INTO `recruitment_company_industry_sector` VALUES (23, 12, 1);
INSERT INTO `recruitment_company_industry_sector` VALUES (24, 12, 21);
INSERT INTO `recruitment_company_industry_sector` VALUES (25, 13, 1);
INSERT INTO `recruitment_company_industry_sector` VALUES (26, 13, 10);
INSERT INTO `recruitment_company_industry_sector` VALUES (27, 14, 1);
INSERT INTO `recruitment_company_industry_sector` VALUES (28, 14, 19);
INSERT INTO `recruitment_company_industry_sector` VALUES (29, 15, 24);
INSERT INTO `recruitment_company_industry_sector` VALUES (30, 15, 25);
INSERT INTO `recruitment_company_industry_sector` VALUES (31, 16, 7);
INSERT INTO `recruitment_company_industry_sector` VALUES (32, 16, 19);

-- ----------------------------
-- Table structure for recruitment_company_tags
-- ----------------------------
DROP TABLE IF EXISTS `recruitment_company_tags`;
CREATE TABLE `recruitment_company_tags`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `company_id` int(11) NOT NULL,
  `companytag_id` int(11) NOT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `Recruitment_company_tags_company_id_companytag_id_98d41333_uniq`(`company_id`, `companytag_id`) USING BTREE,
  INDEX `Recruitment_company__companytag_id_f71bbe24_fk_Recruitme`(`companytag_id`) USING BTREE,
  CONSTRAINT `Recruitment_company__company_id_f426a271_fk_Recruitme` FOREIGN KEY (`company_id`) REFERENCES `recruitment_company` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `Recruitment_company__companytag_id_f71bbe24_fk_Recruitme` FOREIGN KEY (`companytag_id`) REFERENCES `recruitment_companytag` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 53 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of recruitment_company_tags
-- ----------------------------
INSERT INTO `recruitment_company_tags` VALUES (1, 1, 5);
INSERT INTO `recruitment_company_tags` VALUES (2, 1, 6);
INSERT INTO `recruitment_company_tags` VALUES (3, 1, 11);
INSERT INTO `recruitment_company_tags` VALUES (4, 1, 21);
INSERT INTO `recruitment_company_tags` VALUES (5, 2, 6);
INSERT INTO `recruitment_company_tags` VALUES (6, 2, 13);
INSERT INTO `recruitment_company_tags` VALUES (7, 2, 17);
INSERT INTO `recruitment_company_tags` VALUES (8, 2, 19);
INSERT INTO `recruitment_company_tags` VALUES (9, 3, 8);
INSERT INTO `recruitment_company_tags` VALUES (10, 3, 12);
INSERT INTO `recruitment_company_tags` VALUES (11, 3, 18);
INSERT INTO `recruitment_company_tags` VALUES (12, 4, 6);
INSERT INTO `recruitment_company_tags` VALUES (13, 4, 7);
INSERT INTO `recruitment_company_tags` VALUES (14, 4, 20);
INSERT INTO `recruitment_company_tags` VALUES (15, 5, 13);
INSERT INTO `recruitment_company_tags` VALUES (16, 5, 18);
INSERT INTO `recruitment_company_tags` VALUES (17, 5, 19);
INSERT INTO `recruitment_company_tags` VALUES (18, 6, 4);
INSERT INTO `recruitment_company_tags` VALUES (19, 6, 6);
INSERT INTO `recruitment_company_tags` VALUES (20, 6, 13);
INSERT INTO `recruitment_company_tags` VALUES (21, 6, 19);
INSERT INTO `recruitment_company_tags` VALUES (22, 7, 5);
INSERT INTO `recruitment_company_tags` VALUES (23, 7, 11);
INSERT INTO `recruitment_company_tags` VALUES (24, 7, 22);
INSERT INTO `recruitment_company_tags` VALUES (25, 8, 9);
INSERT INTO `recruitment_company_tags` VALUES (26, 8, 10);
INSERT INTO `recruitment_company_tags` VALUES (27, 8, 16);
INSERT INTO `recruitment_company_tags` VALUES (28, 9, 1);
INSERT INTO `recruitment_company_tags` VALUES (29, 9, 11);
INSERT INTO `recruitment_company_tags` VALUES (30, 10, 1);
INSERT INTO `recruitment_company_tags` VALUES (31, 10, 12);
INSERT INTO `recruitment_company_tags` VALUES (32, 11, 1);
INSERT INTO `recruitment_company_tags` VALUES (33, 11, 6);
INSERT INTO `recruitment_company_tags` VALUES (34, 11, 7);
INSERT INTO `recruitment_company_tags` VALUES (35, 12, 4);
INSERT INTO `recruitment_company_tags` VALUES (36, 12, 7);
INSERT INTO `recruitment_company_tags` VALUES (37, 12, 20);
INSERT INTO `recruitment_company_tags` VALUES (38, 13, 1);
INSERT INTO `recruitment_company_tags` VALUES (39, 13, 6);
INSERT INTO `recruitment_company_tags` VALUES (40, 13, 10);
INSERT INTO `recruitment_company_tags` VALUES (41, 13, 13);
INSERT INTO `recruitment_company_tags` VALUES (42, 14, 1);
INSERT INTO `recruitment_company_tags` VALUES (43, 14, 5);
INSERT INTO `recruitment_company_tags` VALUES (44, 14, 13);
INSERT INTO `recruitment_company_tags` VALUES (45, 14, 17);
INSERT INTO `recruitment_company_tags` VALUES (46, 15, 4);
INSERT INTO `recruitment_company_tags` VALUES (47, 15, 5);
INSERT INTO `recruitment_company_tags` VALUES (48, 15, 6);
INSERT INTO `recruitment_company_tags` VALUES (49, 15, 14);
INSERT INTO `recruitment_company_tags` VALUES (50, 16, 5);
INSERT INTO `recruitment_company_tags` VALUES (51, 16, 6);
INSERT INTO `recruitment_company_tags` VALUES (52, 16, 14);

-- ----------------------------
-- Table structure for recruitment_companyauthfile
-- ----------------------------
DROP TABLE IF EXISTS `recruitment_companyauthfile`;
CREATE TABLE `recruitment_companyauthfile`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `file_path` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `company_id` int(11) NOT NULL,
  `status` smallint(6) NOT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `company_id`(`company_id`) USING BTREE,
  CONSTRAINT `Recruitment_companya_company_id_8e57b7d2_fk_Recruitme` FOREIGN KEY (`company_id`) REFERENCES `recruitment_company` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 3 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of recruitment_companyauthfile
-- ----------------------------
INSERT INTO `recruitment_companyauthfile` VALUES (1, 'static/Company/auth/3a7ac662-636b-11e9-87d4-b46d83399436c (5).png', 4, 0);
INSERT INTO `recruitment_companyauthfile` VALUES (2, 'static/Company/auth/2b86afb8-68ab-11e9-8b50-b46d83399436c (4).png', 8, 1);

-- ----------------------------
-- Table structure for recruitment_companyfoundingteam
-- ----------------------------
DROP TABLE IF EXISTS `recruitment_companyfoundingteam`;
CREATE TABLE `recruitment_companyfoundingteam`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `founder_name` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `current_position` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `sina` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `desc` varchar(500) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `photo` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `company_id` int(11) NOT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `company_id`(`company_id`) USING BTREE,
  CONSTRAINT `Recruitment_companyf_company_id_83bf9af7_fk_Recruitme` FOREIGN KEY (`company_id`) REFERENCES `recruitment_company` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 5 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of recruitment_companyfoundingteam
-- ----------------------------
INSERT INTO `recruitment_companyfoundingteam` VALUES (1, '胡万里', '董事长', '', '(1)个人资料：姓名、性别、出生年月、家庭地址、政治面貌、婚姻状况，身体状况，兴趣、爱好、性格等等；\r\n(2)学业有关内容：就读学校、所学专业、学位、外语及计算机掌握程度等等；\r\n(3)本人经历：入学以来的简单经历，主要是担任社会工作或加入党团等方面的情况；\r\n(4)所获荣誉；三好学生、优秀团员、优秀学生干部、专项奖学金等；\r\n\r\n(5)本人特长：如计算机、外语、驾驶、文艺体育等。', '', 1);
INSERT INTO `recruitment_companyfoundingteam` VALUES (2, '古永锵', 'CEO', 'www.sina.com', '古永锵曾经是搜狐的总裁兼首席运营官，他对于搜狐的发展有不可代替的作用。后来他选择了离职，重新回到国内互联网界，创办了一个视频网站—优酷，利用其十几年职业生涯积累起来的强大资源，使优酷获得了迅速发展，一年之间便成为国内视频网站的代表。', 'static/Company/founder/467723ba-633b-11e9-9ee4-b46d83399436c (1).png', 2);
INSERT INTO `recruitment_companyfoundingteam` VALUES (3, '吴智圣', 'CEO', 'www.sina.com', '蘑菇街是专注于时尚女性消费者的电子商务网站，是时尚和生活方式目的地，通过形式多样的时尚内容等时尚商品，让人们在分享和发现流行趋势的同时，享受购物体验 [1-2]  。2011年，蘑菇街正式上线 [3]  ，2016年与美丽说战略融合 [4]  ，旗下包括：蘑菇街、美丽说、uni等产品与服务', 'static/Company/founder/ae53033e-6341-11e9-9b0c-b46d83399436c (5).png', 4);
INSERT INTO `recruitment_companyfoundingteam` VALUES (4, '王尼玛', '总经理', 'www.sina.com', '由于有固定的人物设定，可由不具备美术功底的普通网民制作并发布。题材往往是贴近生活的糗事，也有少量讽刺性和严肃的反思性题材。暴走漫画注重通过夸张的头像，来表达漫画人物的心情，通常是愤怒、开心和无语。暴走漫画人物的头像特点通常在于嘴和眼。是近几年兴起的一种新鲜的网络恶搞，在网民（尤其学生群体）中引起了疯狂的关注。', 'static/Company/founder/d815d124-6342-11e9-a08c-b46d83399436bzdt.jpg', 5);

-- ----------------------------
-- Table structure for recruitment_companyintroduction
-- ----------------------------
DROP TABLE IF EXISTS `recruitment_companyintroduction`;
CREATE TABLE `recruitment_companyintroduction`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `introduction` longtext CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `company_id` int(11) NOT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `company_id`(`company_id`) USING BTREE,
  CONSTRAINT `Recruitment_companyi_company_id_cd0ebfd7_fk_Recruitme` FOREIGN KEY (`company_id`) REFERENCES `recruitment_company` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 16 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of recruitment_companyintroduction
-- ----------------------------
INSERT INTO `recruitment_companyintroduction` VALUES (1, '国馆，中国文化白酒领导品牌。国馆致力于中华五千年文化、尤其是酒文化的研究和探索，通过白酒与艺术跨界结合的方式，重新发掘传统文化的精髓，让更多的人领略中国传统之美，让美酒成为中国文化最温暖的表达方式。 近年来，国馆联合中国酿酒大师与各界艺术家，在国内发起一场“酒以载道”的酒文化运动。国馆携手中国艺术大师、书法名家先后推出的「国馆·中国道」、「国馆·文化中国」等系列产品，奠定了国馆“中国文化白酒领导品牌”的地位。', 1);
INSERT INTO `recruitment_companyintroduction` VALUES (2, '优酷网拥有世界级的风险投资支持，是国内视频领域屈指可数的获得1亿元人民币以上投资的网站之一。投资方包括硅谷历史最悠久的风险投资公司Sutter Hill Ventures，世界上最大投资基金之一的Farallon Capital，还有中国本土唯一的常青基金Chengwei Ventures。这些投资机构实力强劲，其共同特点是资金雄厚，具有远见卓识，为优酷网稳健、有序的长远发展战略提供了充足的弹药。', 2);
INSERT INTO `recruitment_companyintroduction` VALUES (3, '科技是生产力，美丽也是生产力\r\n只做对客户有价值的事\r\n最好的关系，是相互成就\r\n做真实的人，让世界变简单', 4);
INSERT INTO `recruitment_companyintroduction` VALUES (4, '暴走漫画（Rage Comic），简称暴漫，起源于2007年7月17日的北美，在匿名贴图网站上，一名无名氏网友用Windows画板画了一则四格漫画，讲述一个人在蹲厕所时，会有水溅到屁股上，令其十分愤怒。\r\n虽然这幅四格漫画中的线条非常简陋，但因其绘制简单、效果清晰而获得网友广泛认同，并奠定了暴走漫画的基调，即暴走漫画用来讲述日常生活中的琐事，特征是粗犷、通俗、不顾美感的鼠标绘画，这一漫画形式随后逐渐形成潮流，通过网络流传到北美以外，中国、日本、西欧乃至中东的网络上都有暴漫流行的身影。并成为了暴漫喜爱者的生活必需品。\r\n200', 5);
INSERT INTO `recruitment_companyintroduction` VALUES (5, '搜狐公司推出了全球首个第三代互动式中文搜索引擎——搜狗。“搜狗”的问世标志着全球首个第三代互动式中文搜索引擎诞生，是搜索技术发展史上的重要里程碑。', 6);
INSERT INTO `recruitment_companyintroduction` VALUES (6, '蓝鲸的身躯是如此的巨大，以致于一条舌头就有2000千克，头骨有3000千克，肝脏有1000千克，心脏有500千克，血液循环量达8000千克，雄兽的睾丸也有45千克。如果把它的肠子拉直，足有200-300米，血管粗得足以装下一个小孩，脏壁厚达60多厘米，雄兽的阴茎长达3米。它的力量也大得惊人，所发出的功率约为1500-1700马力，堪称是动物世界中当之无愧的巨大霸和大力士。', 7);
INSERT INTO `recruitment_companyintroduction` VALUES (7, '携程是一个在线票务服务公司，创立于1999年，总部设在中国上海。携程旅行网拥有国内外六十余万家会员酒店可供预订，是中国领先的酒店预订服务中心。', 8);
INSERT INTO `recruitment_companyintroduction` VALUES (8, '上海淘米网络科技有限公司（简称淘米公司），成立于2007年，是中国第一家通过线上虚拟社区创建面向儿童寓教于乐的领先儿童娱乐媒体公司。', 9);
INSERT INTO `recruitment_companyintroduction` VALUES (9, '联想集团是1984年中国科学院计算技术研究所投资20万元人民币，由11名科技人员创办，是中国的一家在信息产业内多元化发展的大型企业集团，和富有创新性的国际化的科技公司。', 10);
INSERT INTO `recruitment_companyintroduction` VALUES (10, '为了让更多的人可以得到专业的肌肤护理咨询及解决方案，2009年，韩国瓷肌品牌创始人以医学研究为基础，融合现代护肤理念，创建了专业护肤品牌——韩国瓷肌（CHNSKIN KOREA）。\r\n问题肌，用韩国瓷肌，韩国瓷肌（CHNSKIN KOREA）专注攻克肌肤问题。', 11);
INSERT INTO `recruitment_companyintroduction` VALUES (11, '强烈推荐5秒钟设置堆糖收集工具。把它拖入书签栏之后，就可以在浏览网页时，点击收集工具即可，随时收集自己喜爱的图文内容。一键就可以完成保存。', 12);
INSERT INTO `recruitment_companyintroduction` VALUES (12, '北京思特奇信息技术股份有限公司 [1]  专注于科技开发与创新研究。\r\n近年来，公司投入研发云和大数据的通用平台产品及其演进的技术，建立了公有云和大数据服务。公司自主研发了Iaas和PaaS层产品软件，确保满足4G同时能够演进扩展到5G网络，搭建大数据平台与应用满足电信运营商4G互联网业务的支撑需要。公司还致力于打造移动互联网运营服务的生态圈，开发为中小企业提供云和大数据移动互联网服务的平台。', 13);
INSERT INTO `recruitment_companyintroduction` VALUES (13, '我们眼里的好创意不是创意人员的孤芳自赏,更不是广告主的个人喜好，而应该是一种恰到好处的神来之笔，一种能为品牌的传播和市场的开拓,充当先锋的强劲动力!\r\n我们深知用良好的专业精神,通过创意和美学创造帮助企业创造品牌形象识别并精确传达的使命，我们擅于深入挖掘每一个企业的独特潜质和传播内涵！\r\n我们追求有深入洞见的洞察，像手术刀一样精准的营销策略，独出一格的创意和四两拨千斤的传播方式，好的营销应该像SARS病毒，简洁，迅速，润物细无声而又伤人于无形！', 14);
INSERT INTO `recruitment_companyintroduction` VALUES (14, '了解北京博雅恒辉咨询顾问有限公司的工作环境。立即免费加入领英。', 15);
INSERT INTO `recruitment_companyintroduction` VALUES (15, '公司对每一位员工的工作、生活十分关注，因此在提供五险一金、补充医疗、商业保险等各项保障之余，公司兼有轻松的工作氛围、舒适的办公环境、定期的专业培训、丰盛的下午茶餐、实用的健身课程等各项人文关怀，皆旨在使所有员工能对公司共建家园的企业文化有认同感，使每一个人用更顺畅的心情、更优越的生活来更好的全情投入工作，更好的服务客户，创造自身价值，放飞做创业人的梦想。', 16);

-- ----------------------------
-- Table structure for recruitment_companyproduct
-- ----------------------------
DROP TABLE IF EXISTS `recruitment_companyproduct`;
CREATE TABLE `recruitment_companyproduct`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `product_poster` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `product_name` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `product_url` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `product_desc` varchar(500) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `company_id` int(11) NOT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `company_id`(`company_id`) USING BTREE,
  CONSTRAINT `Recruitment_companyp_company_id_fefd340b_fk_Recruitme` FOREIGN KEY (`company_id`) REFERENCES `recruitment_company` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 3 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of recruitment_companyproduct
-- ----------------------------
INSERT INTO `recruitment_companyproduct` VALUES (1, '', '', '', '', 1);
INSERT INTO `recruitment_companyproduct` VALUES (2, 'static/Company/Product/caafc7ee-633b-11e9-a8a4-b46d83399436qq.png', '优酷网', 'https://www.youku.com/', '优酷、土豆两大视频平台覆盖5.8亿多屏终端、日播放量11.8亿，支持PC、电视、移动三大终端，兼具版权、合制、自制、自频道、直播、VR等多种内容形态。业务覆盖会员、游戏、支...', 2);

-- ----------------------------
-- Table structure for recruitment_companytag
-- ----------------------------
DROP TABLE IF EXISTS `recruitment_companytag`;
CREATE TABLE `recruitment_companytag`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `tag_sort_id` int(11) NOT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `Recruitment_companyt_tag_sort_id_a03448f9_fk_Recruitme`(`tag_sort_id`) USING BTREE,
  CONSTRAINT `Recruitment_companyt_tag_sort_id_a03448f9_fk_Recruitme` FOREIGN KEY (`tag_sort_id`) REFERENCES `recruitment_tagsort` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 23 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of recruitment_companytag
-- ----------------------------
INSERT INTO `recruitment_companytag` VALUES (1, '年终分红', 1);
INSERT INTO `recruitment_companytag` VALUES (2, '绩效奖金', 1);
INSERT INTO `recruitment_companytag` VALUES (3, '股票期权', 1);
INSERT INTO `recruitment_companytag` VALUES (4, '专项奖金', 1);
INSERT INTO `recruitment_companytag` VALUES (5, '年底双薪', 1);
INSERT INTO `recruitment_companytag` VALUES (6, '五险一金', 2);
INSERT INTO `recruitment_companytag` VALUES (7, '通讯津贴', 2);
INSERT INTO `recruitment_companytag` VALUES (8, '交通补助', 2);
INSERT INTO `recruitment_companytag` VALUES (9, '带薪年假', 2);
INSERT INTO `recruitment_companytag` VALUES (10, '免费班车', 3);
INSERT INTO `recruitment_companytag` VALUES (11, '节日礼物', 3);
INSERT INTO `recruitment_companytag` VALUES (12, '年度旅游', 3);
INSERT INTO `recruitment_companytag` VALUES (13, '弹性工作', 3);
INSERT INTO `recruitment_companytag` VALUES (14, '定期体检', 3);
INSERT INTO `recruitment_companytag` VALUES (15, '午餐补助', 3);
INSERT INTO `recruitment_companytag` VALUES (16, '岗位晋升', 4);
INSERT INTO `recruitment_companytag` VALUES (17, '技能培训', 4);
INSERT INTO `recruitment_companytag` VALUES (18, '管理规范', 4);
INSERT INTO `recruitment_companytag` VALUES (19, '扁平管理', 4);
INSERT INTO `recruitment_companytag` VALUES (20, '领导好', 4);
INSERT INTO `recruitment_companytag` VALUES (21, '美女多', 4);
INSERT INTO `recruitment_companytag` VALUES (22, '帅哥多', 4);

-- ----------------------------
-- Table structure for recruitment_industrysector
-- ----------------------------
DROP TABLE IF EXISTS `recruitment_industrysector`;
CREATE TABLE `recruitment_industrysector`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `sector` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 26 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of recruitment_industrysector
-- ----------------------------
INSERT INTO `recruitment_industrysector` VALUES (1, '移动互联网');
INSERT INTO `recruitment_industrysector` VALUES (2, '电子商务');
INSERT INTO `recruitment_industrysector` VALUES (3, '社交');
INSERT INTO `recruitment_industrysector` VALUES (4, '企业服务');
INSERT INTO `recruitment_industrysector` VALUES (5, 'O2O');
INSERT INTO `recruitment_industrysector` VALUES (6, '教育');
INSERT INTO `recruitment_industrysector` VALUES (7, '文化艺术');
INSERT INTO `recruitment_industrysector` VALUES (8, '游戏');
INSERT INTO `recruitment_industrysector` VALUES (9, '在线旅游');
INSERT INTO `recruitment_industrysector` VALUES (10, '金融互联网');
INSERT INTO `recruitment_industrysector` VALUES (11, '健康医疗');
INSERT INTO `recruitment_industrysector` VALUES (12, '生活服务');
INSERT INTO `recruitment_industrysector` VALUES (13, '硬件');
INSERT INTO `recruitment_industrysector` VALUES (14, '搜索');
INSERT INTO `recruitment_industrysector` VALUES (15, '安全');
INSERT INTO `recruitment_industrysector` VALUES (16, '运动体育');
INSERT INTO `recruitment_industrysector` VALUES (17, '云计算\\大数据');
INSERT INTO `recruitment_industrysector` VALUES (18, '移动广告');
INSERT INTO `recruitment_industrysector` VALUES (19, '社会化营销');
INSERT INTO `recruitment_industrysector` VALUES (20, '视频多媒体');
INSERT INTO `recruitment_industrysector` VALUES (21, '媒体');
INSERT INTO `recruitment_industrysector` VALUES (22, '智能家居');
INSERT INTO `recruitment_industrysector` VALUES (23, '智能电视');
INSERT INTO `recruitment_industrysector` VALUES (24, '分类信息');
INSERT INTO `recruitment_industrysector` VALUES (25, '招聘');

-- ----------------------------
-- Table structure for recruitment_position
-- ----------------------------
DROP TABLE IF EXISTS `recruitment_position`;
CREATE TABLE `recruitment_position`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `level` int(11) NOT NULL,
  `pid_id` int(11) NULL DEFAULT NULL,
  `hot` int(11) NOT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `Recruitment_position_pid_id_11df4037_fk_Recruitment_position_id`(`pid_id`) USING BTREE,
  INDEX `Recruitment_position_hot_54ab5b2c`(`hot`) USING BTREE,
  INDEX `Recruitment_position_level_072b0b07`(`level`) USING BTREE,
  CONSTRAINT `Recruitment_position_pid_id_11df4037_fk_Recruitment_position_id` FOREIGN KEY (`pid_id`) REFERENCES `recruitment_position` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 180 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of recruitment_position
-- ----------------------------
INSERT INTO `recruitment_position` VALUES (1, '技术', 1, NULL, 0);
INSERT INTO `recruitment_position` VALUES (2, '产品', 1, NULL, 0);
INSERT INTO `recruitment_position` VALUES (3, '设计', 1, NULL, 0);
INSERT INTO `recruitment_position` VALUES (4, '运营', 1, NULL, 0);
INSERT INTO `recruitment_position` VALUES (5, '市场与销售', 1, NULL, 0);
INSERT INTO `recruitment_position` VALUES (6, '职能', 1, NULL, 0);
INSERT INTO `recruitment_position` VALUES (7, '后端开发', 2, 1, 0);
INSERT INTO `recruitment_position` VALUES (8, 'Java', 3, 7, 1);
INSERT INTO `recruitment_position` VALUES (9, 'C + +', 3, 7, 0);
INSERT INTO `recruitment_position` VALUES (10, 'PHP', 3, 7, 0);
INSERT INTO `recruitment_position` VALUES (11, '数据挖掘', 3, 7, 0);
INSERT INTO `recruitment_position` VALUES (12, 'C', 3, 7, 0);
INSERT INTO `recruitment_position` VALUES (13, 'C  #', 3, 7, 0);
INSERT INTO `recruitment_position` VALUES (14, '.NET', 3, 7, 0);
INSERT INTO `recruitment_position` VALUES (15, 'Hadoop', 3, 7, 0);
INSERT INTO `recruitment_position` VALUES (16, 'Python', 3, 7, 2);
INSERT INTO `recruitment_position` VALUES (17, 'Delphi', 3, 7, 0);
INSERT INTO `recruitment_position` VALUES (18, 'VB', 3, 7, 0);
INSERT INTO `recruitment_position` VALUES (19, 'Perl', 3, 7, 0);
INSERT INTO `recruitment_position` VALUES (20, 'Ruby', 3, 7, 0);
INSERT INTO `recruitment_position` VALUES (21, 'Node.js', 3, 7, 0);
INSERT INTO `recruitment_position` VALUES (22, '移动开发', 2, 1, 0);
INSERT INTO `recruitment_position` VALUES (23, 'HTML5', 3, 22, 0);
INSERT INTO `recruitment_position` VALUES (24, 'Android', 3, 22, 0);
INSERT INTO `recruitment_position` VALUES (25, 'iOS', 3, 22, 0);
INSERT INTO `recruitment_position` VALUES (26, 'WP', 3, 22, 0);
INSERT INTO `recruitment_position` VALUES (27, '前端开发', 2, 1, 0);
INSERT INTO `recruitment_position` VALUES (28, 'web前端', 3, 27, 0);
INSERT INTO `recruitment_position` VALUES (29, 'Flash', 3, 27, 0);
INSERT INTO `recruitment_position` VALUES (30, 'html5', 3, 27, 0);
INSERT INTO `recruitment_position` VALUES (31, 'JavaScript', 3, 27, 0);
INSERT INTO `recruitment_position` VALUES (32, 'U3D', 3, 27, 0);
INSERT INTO `recruitment_position` VALUES (33, 'COCOS2D - X', 3, 27, 0);
INSERT INTO `recruitment_position` VALUES (34, '测试', 2, 1, 0);
INSERT INTO `recruitment_position` VALUES (35, '测试工程师', 3, 34, 0);
INSERT INTO `recruitment_position` VALUES (36, '自动化测试', 3, 34, 0);
INSERT INTO `recruitment_position` VALUES (37, '功能测试', 3, 34, 0);
INSERT INTO `recruitment_position` VALUES (38, '性能测试', 3, 34, 0);
INSERT INTO `recruitment_position` VALUES (39, '测试开发', 3, 34, 0);
INSERT INTO `recruitment_position` VALUES (40, '运维', 2, 1, 0);
INSERT INTO `recruitment_position` VALUES (41, '运维工程师', 3, 40, 0);
INSERT INTO `recruitment_position` VALUES (42, '运维开发工程师', 3, 40, 0);
INSERT INTO `recruitment_position` VALUES (43, '网络工程师', 3, 40, 0);
INSERT INTO `recruitment_position` VALUES (44, '系统工程师', 3, 40, 0);
INSERT INTO `recruitment_position` VALUES (45, 'IT支持', 3, 40, 0);
INSERT INTO `recruitment_position` VALUES (46, 'DBA', 2, 1, 0);
INSERT INTO `recruitment_position` VALUES (47, 'MySQL', 3, 46, 0);
INSERT INTO `recruitment_position` VALUES (48, 'SQLServer', 3, 46, 0);
INSERT INTO `recruitment_position` VALUES (49, 'Oracle', 3, 46, 0);
INSERT INTO `recruitment_position` VALUES (50, 'DB2', 3, 46, 0);
INSERT INTO `recruitment_position` VALUES (51, 'MongoDB', 3, 46, 0);
INSERT INTO `recruitment_position` VALUES (52, '项目管理', 2, 1, 0);
INSERT INTO `recruitment_position` VALUES (53, '项目经理', 3, 52, 0);
INSERT INTO `recruitment_position` VALUES (54, '高端技术职位', 2, 1, 0);
INSERT INTO `recruitment_position` VALUES (55, '技术经理', 3, 54, 0);
INSERT INTO `recruitment_position` VALUES (56, '技术总监', 3, 54, 0);
INSERT INTO `recruitment_position` VALUES (57, '测试经理', 3, 54, 0);
INSERT INTO `recruitment_position` VALUES (58, '架构师', 3, 54, 0);
INSERT INTO `recruitment_position` VALUES (59, 'CTO', 3, 54, 0);
INSERT INTO `recruitment_position` VALUES (60, '运维总监', 3, 54, 0);
INSERT INTO `recruitment_position` VALUES (61, '产品经理', 2, 2, 0);
INSERT INTO `recruitment_position` VALUES (62, '产品经理', 3, 61, 0);
INSERT INTO `recruitment_position` VALUES (63, '网页产品经理', 3, 61, 0);
INSERT INTO `recruitment_position` VALUES (64, '移动产品经理', 3, 61, 0);
INSERT INTO `recruitment_position` VALUES (65, '产品助理', 3, 61, 0);
INSERT INTO `recruitment_position` VALUES (66, '数据产品经理', 3, 61, 0);
INSERT INTO `recruitment_position` VALUES (67, '电商产品经理', 3, 61, 0);
INSERT INTO `recruitment_position` VALUES (68, '游戏策划', 3, 61, 0);
INSERT INTO `recruitment_position` VALUES (69, '产品设计师', 2, 2, 0);
INSERT INTO `recruitment_position` VALUES (70, '网页产品设计师', 3, 69, 0);
INSERT INTO `recruitment_position` VALUES (71, '无线产品设计师', 3, 69, 0);
INSERT INTO `recruitment_position` VALUES (72, '高端产品职位', 2, 2, 0);
INSERT INTO `recruitment_position` VALUES (73, '产品部经理', 3, 72, 0);
INSERT INTO `recruitment_position` VALUES (74, '产品总监', 3, 72, 0);
INSERT INTO `recruitment_position` VALUES (75, '视觉设计', 2, 3, 0);
INSERT INTO `recruitment_position` VALUES (76, '视觉设计师', 3, 75, 0);
INSERT INTO `recruitment_position` VALUES (77, '网页设计师', 3, 75, 0);
INSERT INTO `recruitment_position` VALUES (78, 'Flash设计师', 3, 75, 0);
INSERT INTO `recruitment_position` VALUES (79, 'APP设计师', 3, 75, 0);
INSERT INTO `recruitment_position` VALUES (80, 'UI设计师', 3, 75, 0);
INSERT INTO `recruitment_position` VALUES (81, '平面设计师', 3, 75, 0);
INSERT INTO `recruitment_position` VALUES (82, '美术设计师（2 D / 3 D）', 3, 75, 0);
INSERT INTO `recruitment_position` VALUES (83, '广告设计师', 3, 75, 0);
INSERT INTO `recruitment_position` VALUES (84, '多媒体设计师', 3, 75, 0);
INSERT INTO `recruitment_position` VALUES (85, '原画师', 3, 75, 0);
INSERT INTO `recruitment_position` VALUES (86, '游戏特效', 3, 75, 0);
INSERT INTO `recruitment_position` VALUES (87, '游戏界面设计师', 3, 75, 0);
INSERT INTO `recruitment_position` VALUES (88, '游戏场景', 3, 75, 0);
INSERT INTO `recruitment_position` VALUES (89, '游戏角色', 3, 75, 0);
INSERT INTO `recruitment_position` VALUES (90, '游戏动作', 3, 75, 0);
INSERT INTO `recruitment_position` VALUES (91, '交互设计', 2, 3, 0);
INSERT INTO `recruitment_position` VALUES (92, '交互设计师', 3, 91, 0);
INSERT INTO `recruitment_position` VALUES (93, '无线交互设计师', 3, 91, 0);
INSERT INTO `recruitment_position` VALUES (94, '网页交互设计师', 3, 91, 0);
INSERT INTO `recruitment_position` VALUES (95, '硬件交互设计师', 3, 91, 0);
INSERT INTO `recruitment_position` VALUES (96, '用户研究', 2, 3, 0);
INSERT INTO `recruitment_position` VALUES (97, '数据分析师', 3, 96, 0);
INSERT INTO `recruitment_position` VALUES (98, '用户研究员', 3, 96, 0);
INSERT INTO `recruitment_position` VALUES (99, '游戏数值策划', 3, 96, 0);
INSERT INTO `recruitment_position` VALUES (100, '高端设计职位', 2, 3, 0);
INSERT INTO `recruitment_position` VALUES (101, '设计经理 / 主管', 3, 100, 0);
INSERT INTO `recruitment_position` VALUES (102, '设计总监', 3, 100, 0);
INSERT INTO `recruitment_position` VALUES (103, '视觉设计经理', 3, 100, 0);
INSERT INTO `recruitment_position` VALUES (104, '视觉设计总监', 3, 100, 0);
INSERT INTO `recruitment_position` VALUES (105, '交互设计经理 / 主管', 3, 100, 0);
INSERT INTO `recruitment_position` VALUES (106, '交互设计总监', 3, 100, 0);
INSERT INTO `recruitment_position` VALUES (107, '用户研究经理 / 主管', 3, 100, 0);
INSERT INTO `recruitment_position` VALUES (108, '用户研究总监', 3, 100, 0);
INSERT INTO `recruitment_position` VALUES (109, '运营', 2, 4, 0);
INSERT INTO `recruitment_position` VALUES (110, '用户运营', 3, 109, 0);
INSERT INTO `recruitment_position` VALUES (111, '产品运营', 3, 109, 0);
INSERT INTO `recruitment_position` VALUES (112, '数据运营', 3, 109, 0);
INSERT INTO `recruitment_position` VALUES (113, '内容运营', 3, 109, 0);
INSERT INTO `recruitment_position` VALUES (114, '活动运营', 3, 109, 0);
INSERT INTO `recruitment_position` VALUES (115, '商家运营', 3, 109, 0);
INSERT INTO `recruitment_position` VALUES (116, '品类运营', 3, 109, 0);
INSERT INTO `recruitment_position` VALUES (117, '游戏运营', 3, 109, 0);
INSERT INTO `recruitment_position` VALUES (118, '网络推广', 3, 109, 0);
INSERT INTO `recruitment_position` VALUES (119, '编辑', 2, 4, 0);
INSERT INTO `recruitment_position` VALUES (120, '副主编', 3, 119, 0);
INSERT INTO `recruitment_position` VALUES (121, '内容编辑', 3, 119, 0);
INSERT INTO `recruitment_position` VALUES (122, '客服', 2, 4, 0);
INSERT INTO `recruitment_position` VALUES (123, '售前咨询', 3, 122, 0);
INSERT INTO `recruitment_position` VALUES (124, '售后客服', 3, 122, 0);
INSERT INTO `recruitment_position` VALUES (125, '高端运营职位', 2, 4, 0);
INSERT INTO `recruitment_position` VALUES (126, '主编', 3, 125, 0);
INSERT INTO `recruitment_position` VALUES (127, '运营总监', 3, 125, 0);
INSERT INTO `recruitment_position` VALUES (128, 'COO', 3, 125, 0);
INSERT INTO `recruitment_position` VALUES (129, '市场 / 营销', 2, 5, 0);
INSERT INTO `recruitment_position` VALUES (130, '市场营销', 3, 129, 0);
INSERT INTO `recruitment_position` VALUES (131, '市场策划', 3, 129, 0);
INSERT INTO `recruitment_position` VALUES (132, '市场顾问', 3, 129, 0);
INSERT INTO `recruitment_position` VALUES (133, '市场推广', 3, 129, 0);
INSERT INTO `recruitment_position` VALUES (134, 'SEO', 3, 129, 0);
INSERT INTO `recruitment_position` VALUES (135, 'SEM', 3, 129, 0);
INSERT INTO `recruitment_position` VALUES (136, '商务渠道', 3, 129, 0);
INSERT INTO `recruitment_position` VALUES (137, '商业数据分析', 3, 129, 0);
INSERT INTO `recruitment_position` VALUES (138, '活动策划', 3, 129, 0);
INSERT INTO `recruitment_position` VALUES (139, '公关', 2, 5, 0);
INSERT INTO `recruitment_position` VALUES (140, '媒介经理', 3, 139, 0);
INSERT INTO `recruitment_position` VALUES (141, '广告协调', 3, 139, 0);
INSERT INTO `recruitment_position` VALUES (142, '品牌公关', 3, 139, 0);
INSERT INTO `recruitment_position` VALUES (143, '销售', 2, 5, 0);
INSERT INTO `recruitment_position` VALUES (144, '销售专员', 3, 143, 0);
INSERT INTO `recruitment_position` VALUES (145, '销售经理', 3, 143, 0);
INSERT INTO `recruitment_position` VALUES (146, '客户代表', 3, 143, 0);
INSERT INTO `recruitment_position` VALUES (147, '大客户代表', 3, 143, 0);
INSERT INTO `recruitment_position` VALUES (148, 'BD经理', 3, 143, 0);
INSERT INTO `recruitment_position` VALUES (149, '商务渠道', 3, 143, 0);
INSERT INTO `recruitment_position` VALUES (150, '渠道销售', 3, 143, 0);
INSERT INTO `recruitment_position` VALUES (151, '代理商销售', 3, 143, 0);
INSERT INTO `recruitment_position` VALUES (152, '高端市场职位', 2, 5, 0);
INSERT INTO `recruitment_position` VALUES (153, '市场总监', 3, 152, 0);
INSERT INTO `recruitment_position` VALUES (154, '销售总监', 3, 152, 0);
INSERT INTO `recruitment_position` VALUES (155, '商务总监', 3, 152, 0);
INSERT INTO `recruitment_position` VALUES (156, 'CMO', 3, 152, 0);
INSERT INTO `recruitment_position` VALUES (157, '公关总监', 3, 152, 0);
INSERT INTO `recruitment_position` VALUES (158, '人力资源', 2, 6, 0);
INSERT INTO `recruitment_position` VALUES (159, '人力资源', 3, 158, 0);
INSERT INTO `recruitment_position` VALUES (160, '招聘', 3, 158, 0);
INSERT INTO `recruitment_position` VALUES (161, 'HRBP', 3, 158, 0);
INSERT INTO `recruitment_position` VALUES (162, '人事 / HR', 3, 158, 0);
INSERT INTO `recruitment_position` VALUES (163, '培训经理', 3, 158, 0);
INSERT INTO `recruitment_position` VALUES (164, '薪资福利经理', 3, 158, 0);
INSERT INTO `recruitment_position` VALUES (165, '绩效考核经理', 3, 158, 0);
INSERT INTO `recruitment_position` VALUES (166, '行政', 2, 6, 0);
INSERT INTO `recruitment_position` VALUES (167, '助理', 3, 166, 0);
INSERT INTO `recruitment_position` VALUES (168, '前台', 3, 166, 0);
INSERT INTO `recruitment_position` VALUES (169, '法务', 3, 166, 0);
INSERT INTO `recruitment_position` VALUES (170, '行政', 3, 166, 0);
INSERT INTO `recruitment_position` VALUES (171, '财务', 2, 6, 0);
INSERT INTO `recruitment_position` VALUES (172, '会计', 3, 171, 0);
INSERT INTO `recruitment_position` VALUES (173, '出纳', 3, 171, 0);
INSERT INTO `recruitment_position` VALUES (174, '财务', 3, 171, 0);
INSERT INTO `recruitment_position` VALUES (175, '高端职能职位', 2, 6, 0);
INSERT INTO `recruitment_position` VALUES (176, '行政总监 / 经理', 3, 175, 0);
INSERT INTO `recruitment_position` VALUES (177, '财务总监 / 经理', 3, 175, 0);
INSERT INTO `recruitment_position` VALUES (178, 'HRD / HRM', 3, 175, 0);
INSERT INTO `recruitment_position` VALUES (179, 'CFO', 3, 175, 0);

-- ----------------------------
-- Table structure for recruitment_positioninfo
-- ----------------------------
DROP TABLE IF EXISTS `recruitment_positioninfo`;
CREATE TABLE `recruitment_positioninfo`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `positionType` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `position` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `department` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `jobNature` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `salaryMin` int(11) NOT NULL,
  `salaryMax` int(11) NOT NULL,
  `workAddress` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `workYear` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `education` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `positionAdvantage` varchar(21) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `positionDetail` longtext CHARACTER SET utf8 COLLATE utf8_general_ci NULL,
  `positionAddress` longtext CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `email` varchar(254) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `positionLng` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `positionLat` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `addTime` datetime(6) NULL,
  `status` smallint(6) NOT NULL,
  `views_count` int(11) NOT NULL,
  `company_id` int(11) NOT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `Recruitment_position_company_id_a2993226_fk_Recruitme`(`company_id`) USING BTREE,
  INDEX `Recruitment_positioninfo_positionType_efccb06a`(`positionType`) USING BTREE,
  INDEX `Recruitment_positioninfo_position_a16c5f25`(`position`) USING BTREE,
  CONSTRAINT `Recruitment_position_company_id_a2993226_fk_Recruitme` FOREIGN KEY (`company_id`) REFERENCES `recruitment_company` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 19 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of recruitment_positioninfo
-- ----------------------------
INSERT INTO `recruitment_positioninfo` VALUES (1, '移动开发', 'iOS', '开发部门', '实习', 2, 3, '黄山', '应届毕业生', '大专', '年轻就要醒着拼！996', '<span style=\"color:#333333;font-family:arial, 宋体, sans-serif;font-size:14px;background-color:#F6F4EC;\">苹果仍没有宣布任何让</span><a target=\"_blank\" href=\"https://baike.baidu.com/item/iPhone\">iPhone</a><span style=\"color:#333333;font-family:arial, 宋体, sans-serif;font-size:14px;background-color:#F6F4EC;\">运行</span><a target=\"_blank\" href=\"https://baike.baidu.com/item/Java\">Java</a><span style=\"color:#333333;font-family:arial, 宋体, sans-serif;font-size:14px;background-color:#F6F4EC;\">的计划。但太阳微系统已</span>\n<div class=\"lemma-picture text-pic \" style=\"border:1px solid #E0E0E0;margin:0px 0px 3px;color:#333333;font-family:arial, 宋体, sans-serif;font-size:14px;background-color:#F6F4EC;\">\n	<a class=\"image-link\" href=\"https://baike.baidu.com/pic/iOS/45705/0/f703738da9773912dd0d287afa198618367ae286?fr=lemma&amp;ct=single\" target=\"_blank\"><img class=\"\" src=\"https://gss2.bdstatic.com/-fo3dSag_xI4khGkpoWK1HF6hhy/baike/s%3D220/sign=c37845ef53da81cb4ae684cf6266d0a4/f703738da9773912dd0d287afa198618367ae286.jpg\" alt=\"\" style=\"width:220px;height:171px;\" /></a>\n</div>\n<span style=\"color:#333333;font-family:arial, 宋体, sans-serif;font-size:14px;background-color:#F6F4EC;\">宣布其将会发布能在iPhone上运行的</span><a target=\"_blank\" href=\"https://baike.baidu.com/item/Java%E8%99%9A%E6%8B%9F%E6%9C%BA\">Java虚拟机</a><span style=\"color:#333333;font-family:arial, 宋体, sans-serif;font-size:14px;background-color:#F6F4EC;\">(</span><a target=\"_blank\" href=\"https://baike.baidu.com/item/JVM\">JVM</a><span style=\"color:#333333;font-family:arial, 宋体, sans-serif;font-size:14px;background-color:#F6F4EC;\">)的计划，它是基于Java的Micro Edition版本。这将让用Java应用程序得以在iPhone和iPod Touch上运行。在这个计划发表之后,熟悉iOS软件开发协议的程序员们相信虽然iOS软件开发协议不允许应用程序后台运行(比如说在接电话的时候仍然运行程序), 但却允许自带的应用程序从其他的来源下载</span><a target=\"_blank\" href=\"https://baike.baidu.com/item/%E4%BB%A3%E7%A0%81\">代码</a><span style=\"color:#333333;font-family:arial, 宋体, sans-serif;font-size:14px;background-color:#F6F4EC;\">，而且它们还能与</span><a target=\"_blank\" href=\"https://baike.baidu.com/item/%E7%AC%AC%E4%B8%89%E6%96%B9%E5%BA%94%E7%94%A8%E7%A8%8B%E5%BA%8F\">第三方应用程序</a><span style=\"color:#333333;font-family:arial, 宋体, sans-serif;font-size:14px;background-color:#F6F4EC;\">相互作用(比如说</span><a target=\"_blank\" href=\"https://baike.baidu.com/item/Safari/597\">Safari</a><span style=\"color:#333333;font-family:arial, 宋体, sans-serif;font-size:14px;background-color:#F6F4EC;\">和</span><a target=\"_blank\" href=\"https://baike.baidu.com/item/Java/85979\">Java</a><span style=\"color:#333333;font-family:arial, 宋体, sans-serif;font-size:14px;background-color:#F6F4EC;\">虚拟机), 这可能会阻碍不与苹果合作的Java虚拟机的发展。 很明显，在iPhone运行的</span><a target=\"_blank\" href=\"https://baike.baidu.com/item/Java\">Java</a><span style=\"color:#333333;font-family:arial, 宋体, sans-serif;font-size:14px;background-color:#F6F4EC;\">在iOS软件开发协议所规定的范畴以外。</span>', '黄山市屯溪区', '1905329584@qq.com', '118.321415', '29.698787', '2019-04-20 15:02:33.389691', 0, 1, 1);
INSERT INTO `recruitment_positioninfo` VALUES (2, '交互设计', '网页交互设计师', '设计部门', '全职', 10, 11, '天津', '1-3年', '本科', '满满的正能量', '<div class=\"para-title level-3\" style=\"margin:20px 0px 12px;font-size:18px;font-family:&quot;color:#333333;background-color:#F6F4EC;\">\n	<h3 class=\"title-text\" style=\"font-size:18px;font-weight:400;\">\n		产品理念\n	</h3>\n</div>\n<div class=\"para\" style=\"font-size:14px;color:#333333;font-family:arial, 宋体, sans-serif;background-color:#F6F4EC;\">\n	与播客有所不同，优酷不一定只有原创才能登台表演，无论业余或专业，无论个人或机构，优酷欢迎一切以微视频形式出现的视频收藏、自创与分享。据优酷网产品负责人介绍，优酷是国内首家为微视频<a target=\"_blank\" href=\"https://baike.baidu.com/item/%E5%85%8D%E8%B4%B9/131326\">免费</a>提供无限量上传与存储空间并具备个人发起视频擂台及评分系统的网站；区别于某些网站的视频堆积，优酷注重利用多纬度的<a target=\"_blank\" href=\"https://baike.baidu.com/item/TOP/16271400\">TOP</a>排名、频道分类索引、标签、个人发起擂台、视频俱乐部等有效手段，兼顾技术搜索功能与人气推荐手段，最大化发挥<a target=\"_blank\" href=\"https://baike.baidu.com/item/C2C\">C2C</a>内容聚合与推荐的力量，帮助用户迅速找到喜好的视频和感兴趣的社区，让用户“看得爽、找得快、传得广、比得酷”。优与酷的融合，势必会吸引大批崇尚自由创意、喜欢收藏或欣赏微视频的网民。优酷的目标人群归属和分众聚合力将为优酷未来的商业价值创造无限可能，也为传统媒体的发行和推广提供新的平台。\n</div>', '天津西青区梅江会展中心', '1302982067@qq.com', '117.220545', '39.047899', '2019-04-20 15:17:50.828158', 1, 0, 2);
INSERT INTO `recruitment_positioninfo` VALUES (3, '客服', '售前咨询', '销售部门', '全职', 4, 6, '北京', '不限', '不限', '团队福利，管理和谐', '<div class=\"para\" style=\"font-size:14px;color:#333333;font-family:arial, 宋体, sans-serif;background-color:#F6F4EC;\">\n	2006年获奖荣誉\n</div>\n<div class=\"para\" style=\"font-size:14px;color:#333333;font-family:arial, 宋体, sans-serif;background-color:#F6F4EC;\">\n	获奖名称：最具发展潜力的保险公司\n</div>\n<div class=\"para\" style=\"font-size:14px;color:#333333;font-family:arial, 宋体, sans-serif;background-color:#F6F4EC;\">\n	颁奖单位：重庆晨报、重庆晚报、华龙网\n</div>\n<div class=\"para\" style=\"font-size:14px;color:#333333;font-family:arial, 宋体, sans-serif;background-color:#F6F4EC;\">\n	2007年获奖荣誉\n</div>\n<div class=\"para\" style=\"font-size:14px;color:#333333;font-family:arial, 宋体, sans-serif;background-color:#F6F4EC;\">\n	获奖名称：2007年最完善的风险管理保险公司\n</div>\n<div class=\"para\" style=\"font-size:14px;color:#333333;font-family:arial, 宋体, sans-serif;background-color:#F6F4EC;\">\n	颁奖单位：重庆晨报\n</div>\n<div class=\"para\" style=\"font-size:14px;color:#333333;font-family:arial, 宋体, sans-serif;background-color:#F6F4EC;\">\n	2008年获奖荣誉\n</div>', '北京五道口嘉园', '1183336596@qq.com', '', '', '2019-04-20 15:52:03.936171', 0, 3, 3);
INSERT INTO `recruitment_positioninfo` VALUES (4, '公关', '品牌公关', '直属公关', '全职', 8, 10, '上海', '3-5年', '本科', '蘑菇街专注于时尚电子商务网站，是时尚生活', '<div class=\"para\" style=\"font-size:14px;color:#333333;font-family:arial, 宋体, sans-serif;background-color:#F6F4EC;\">\n	2015年 建立红人工作平台，建设社会化时尚导购生态体系<span class=\"sup--normal\" style=\"font-size:12px;line-height:0;vertical-align:baseline;color:#3366CC;\">&nbsp;[18]</span><a name=\"ref_[18]_5285473\"></a>&nbsp;\n</div>\n<div class=\"para\" style=\"font-size:14px;color:#333333;font-family:arial, 宋体, sans-serif;background-color:#F6F4EC;\">\n	2016年 创新直播购物模式，打造网红直播电商双十一<span class=\"sup--normal\" style=\"font-size:12px;line-height:0;vertical-align:baseline;color:#3366CC;\">&nbsp;[18]</span><a name=\"ref_[18]_5285473\"></a>&nbsp;\n</div>\n<div class=\"para\" style=\"font-size:14px;color:#333333;font-family:arial, 宋体, sans-serif;background-color:#F6F4EC;\">\n	2017年 构建微信小程序矩阵，成为微信系统内电商的生态建设者<span class=\"sup--normal\" style=\"font-size:12px;line-height:0;vertical-align:baseline;color:#3366CC;\">&nbsp;[18]</span><a name=\"ref_[18]_5285473\"></a>&nbsp;\n</div>\n<div class=\"para\" style=\"font-size:14px;color:#333333;font-family:arial, 宋体, sans-serif;background-color:#F6F4EC;\">\n	2018年 升级时尚主编测评与时尚红人社区，发现和分享时尚潮流<span class=\"sup--normal\" style=\"font-size:12px;line-height:0;vertical-align:baseline;color:#3366CC;\">&nbsp;[18]</span><a name=\"ref_[18]_5285473\"></a>&nbsp;\n</div>\n<div class=\"para\" style=\"font-size:14px;color:#333333;font-family:arial, 宋体, sans-serif;background-color:#F6F4EC;\">\n	蘑菇街在纽交所挂牌上市<span class=\"sup--normal\" style=\"font-size:12px;line-height:0;vertical-align:baseline;color:#3366CC;\">&nbsp;[19]</span><a name=\"ref_[19]_5285473\"></a>&nbsp;\n</div>', '上海闵行区长江科技工业园区', '1131727441@qq.com', '121.387322', '31.074066', '2019-04-20 15:59:29.094232', 0, 0, 4);
INSERT INTO `recruitment_positioninfo` VALUES (5, '编辑', '内容编辑', '新闻编辑部', '全职', 8, 10, '上海', '3-5年', '不限', '因为暴漫我们知道自己并不是一个人在战斗', '<span style=\"color:#333333;font-family:arial, 宋体, sans-serif;font-size:14px;background-color:#F6F4EC;\">王尼玛骨骼惊奇被人戏称大头怪婴，他怪诞邪恶，常被称为无厘头呕像，却还以此为豪。说话犀利讽刺却发人深省，让你欲罢不能的接受他那常人无法理解的奇怪哲学。喜欢恶搞别人，也不在乎把自己的糗事公布于世，并鼓励别人也这么做。他是一个笑星，一个看似无趣的片段也可以被改的笑点乱冒；他是一个老师，可以让你曾经对人生形成的偏激“三观”瞬间扭转；他是一种精神，因为你无论欣喜若狂还是悲痛欲绝时，只要画出他，立刻帮你回归淡定。&emsp;王尼玛的存在，就是要告诉你，别以为只有你一个人曾做过某件事，共鸣的剧情会让你觉得“王尼玛，你是不是在派人跟踪我？”甚至不需要情节，点到即止，你马上就有“找到了组织”的感觉。王尼玛总是喜欢说：“别看别人，说你呢！你的膝盖中枪没？！”“什么？你是躺着的？躺着也让你中枪！”&emsp;处处留心皆暴漫，天下尼玛是一家。“王尼玛有什么了不起的！”没错，因为正握着鼠标做暴漫的你，才是王尼玛伟大的主人！</span>', '上海浦东区由由世纪广场', '1347152542@qq.com', '121.540969', '31.223829', '2019-04-20 16:06:45.312730', 0, 1, 5);
INSERT INTO `recruitment_positioninfo` VALUES (6, '后端开发', 'Hadoop', '客户分析', '全职', 15, 25, '北京', '5-10年', '本科', '有工作气氛，团队团结，有潜力', '<span style=\"color:#333333;font-family:arial, 宋体, sans-serif;font-size:14px;background-color:#F6F4EC;\">搜狐发布公告称，已回购阿里巴巴所持有的搜狗约10%的股份。到此，搜狗与阿里巴巴两年的牵手宣布正式终止，根据协议，搜狐同意从阿里巴巴手中收购阿里巴巴所持搜狗2400万股优先股。收购价格为2580万美元。据计算，搜狗的估值大约在2.37亿美元。由于搜索引擎与电子商务有着天然的联系，互联网上的海量商品需要搜索引擎作为纽带帮助其带来流量和用户。因此，阿里巴巴集团这次选择和一个不与其构成直接竞争关系的搜索引擎合作，将有效帮助其进行业务拓展。</span>', '北京海淀区中关村东路搜狗科技公司', '1174188994@qq.com', '116.338837', '40.000242', '2019-04-20 16:14:59.227562', 0, 3, 6);
INSERT INTO `recruitment_positioninfo` VALUES (7, '财务', '出纳', '财务部门', '全职', 9, 12, '杭州', '1-3年', '硕士', '管理规范，晋升快', '<span style=\"color:#333333;font-family:arial, 宋体, sans-serif;font-size:14px;background-color:#F6F4EC;\">蓝鲸的鳍肢长3-4米。上方为灰色，窄边白色。下方全白。头部和</span><a target=\"_blank\" href=\"https://baike.baidu.com/item/%E5%B0%BE%E9%B3%8D\">尾鳍</a><span style=\"color:#333333;font-family:arial, 宋体, sans-serif;font-size:14px;background-color:#F6F4EC;\">一般为灰色。但是背部，有时还有鳍肢通常是杂色的。杂色的程度因个体而有明显不同。有些可能全身都是灰色，而其他的则是深蓝，灰色和深蓝色相当程度的混合在一起（grey-blue）。</span>', '杭州市上城区解放路24号', 'douzhenghai97@qq.com', '120.190962', '30.255375', '2019-04-20 16:22:09.148579', 1, 3, 7);
INSERT INTO `recruitment_positioninfo` VALUES (8, '人力资源', '培训经理', '人力资源', '全职', 6, 7, '上海', '1-3年', '不限', '福利好同事多', '<span style=\"color:#333333;font-family:arial, 宋体, sans-serif;font-size:14px;background-color:#F6F4EC;\">2012年6月，携程发布新</span><a target=\"_blank\" href=\"https://baike.baidu.com/item/Logo/32134\">Logo</a><span style=\"color:#333333;font-family:arial, 宋体, sans-serif;font-size:14px;background-color:#F6F4EC;\">，以海豚图案为主，由海豚轮廓改变称为蓝色实心，加上眼睛和嘴巴的海豚图案，整体尺寸上有所缩小，主色调则保持原来的蓝橙两色。携程方面解释新logo体现了携程在移动互联网nag的便捷、灵活、智能和创新。但也有用户在微博质疑，新logo中“变瘦”的海豚像“泥鳅”。</span>', '上海市长宁区中山公园', '894149432@qq.com', '121.363167', '31.238263', '2019-04-27 13:13:03.938499', 0, 0, 8);
INSERT INTO `recruitment_positioninfo` VALUES (9, '运营', '内容运营', '文案编辑', '兼职', 3, 5, '北京', '应届毕业生', '本科', '专为儿童互联网产品的策划、研发', '<div class=\"para\" style=\"font-size:14px;color:#333333;font-family:arial, 宋体, sans-serif;background-color:#F6F4EC;\">\n	2008年开始，淘米将“摩尔庄园”、“赛尔号”作图书授权。\n</div>\n<div class=\"para\" style=\"font-size:14px;color:#333333;font-family:arial, 宋体, sans-serif;background-color:#F6F4EC;\">\n	2008年5月10日，淘米推出中国首款儿童在线虚拟社区《摩尔庄园》。\n</div>\n<div class=\"para\" style=\"font-size:14px;color:#333333;font-family:arial, 宋体, sans-serif;background-color:#F6F4EC;\">\n	2009年6月12日，淘米推出第二款儿童在线虚拟社区《<a target=\"_blank\" href=\"https://baike.baidu.com/item/%E8%B5%9B%E5%B0%94%E5%8F%B7/10405\">赛尔号</a>》。\n</div>\n<div class=\"para\" style=\"font-size:14px;color:#333333;font-family:arial, 宋体, sans-serif;background-color:#F6F4EC;\">\n	2009年11月，淘米推出国内首个儿童综合互动娱乐平台“<a target=\"_blank\" href=\"https://baike.baidu.com/item/%E6%B7%98%E7%B1%B3%E7%BD%91\">淘米网</a>”。\n</div>', '北京海淀区中关村东路', 'lizi_i@qq.com', '', '', '2019-04-27 14:47:52.192537', 0, 0, 9);
INSERT INTO `recruitment_positioninfo` VALUES (10, '后端开发', 'Perl', '后端开发', '全职', 8, 10, '北京', '应届毕业生', '本科', '美国《财富》杂志公布全球500强排行榜', '<div class=\"para\" style=\"font-size:14px;color:#333333;font-family:arial, 宋体, sans-serif;background-color:#F6F4EC;\">\n	1984：联想的创始人柳传志带领10名中国<a target=\"_blank\" href=\"https://baike.baidu.com/item/%E8%AE%A1%E7%AE%97%E6%9C%BA\">计算机</a>科技人员前瞻性的认识到了PC必将改变人们的工作和生活。\n</div>\n<div class=\"para\" style=\"font-size:14px;color:#333333;font-family:arial, 宋体, sans-serif;background-color:#F6F4EC;\">\n	IBM推出首款便携式电脑- 重30磅的IBM Portable PC。\n</div>\n<div class=\"para\" style=\"font-size:14px;color:#333333;font-family:arial, 宋体, sans-serif;background-color:#F6F4EC;\">\n	1985：推出第一款具有联想功能的汉卡产品联想式汉卡，联想这一品牌名称由此而来。\n</div>\n<div class=\"para\" style=\"font-size:14px;color:#333333;font-family:arial, 宋体, sans-serif;background-color:#F6F4EC;\">\n	1986：IBM推出最小的全功能<a target=\"_blank\" href=\"https://baike.baidu.com/item/%E4%B8%AA%E4%BA%BA%E7%94%B5%E8%84%91\">个人电脑</a>-重量小于13磅的PC Convertible。\n</div>\n<div class=\"para\" style=\"font-size:14px;color:#333333;font-family:arial, 宋体, sans-serif;background-color:#F6F4EC;\">\n	1987：联想成功推出联想式汉卡。IBM推出 Personal System/2（PS/2）个人电脑系列。\n</div>\n<div class=\"para\" style=\"font-size:14px;color:#333333;font-family:arial, 宋体, sans-serif;background-color:#F6F4EC;\">\n	1988：联想式汉卡荣获中国国家科技进步奖一等奖。香港联想成立。\n</div>\n<div class=\"para\" style=\"font-size:14px;color:#333333;font-family:arial, 宋体, sans-serif;background-color:#F6F4EC;\">\n	1989：北京联想集团公司成立。\n</div>', '北京海淀区中关村东路', '1234567@qq.com', '', '', '2019-04-27 15:40:02.559671', 0, 0, 10);
INSERT INTO `recruitment_positioninfo` VALUES (11, '运营', '活动运营', '运营', '全职', 10, 12, '沈阳', '3-5年', '本科', '始终坚信，不同的肌肤需要不一样的修护', '<a target=\"_blank\" href=\"https://baike.baidu.com/item/%E9%9F%A9%E5%9B%BD/6009333\">韩国</a><span style=\"color:#333333;font-family:arial, 宋体, sans-serif;font-size:14px;background-color:#F6F4EC;\">瓷肌（CHNSKIN KOREA）始终坚信，不同的问题肌肤需要不一样的专业修护。韩国瓷肌结合不同人群、不同肤质特点，配置专业配方，问题肌肤，七分修，三分养，从修、护两方面给予安全有效的解决方案，韩国瓷肌（CHNSKIN KOREA），缔造每个女人本有的</span><a target=\"_blank\" href=\"https://baike.baidu.com/item/%E5%8E%9F%E7%94%9F\">原生</a><span style=\"color:#333333;font-family:arial, 宋体, sans-serif;font-size:14px;background-color:#F6F4EC;\">之</span><a target=\"_blank\" href=\"https://baike.baidu.com/item/%E8%82%8C\">肌</a><span style=\"color:#333333;font-family:arial, 宋体, sans-serif;font-size:14px;background-color:#F6F4EC;\">。</span>', '沈阳莲花乡池水沟子', '1234568@qq.com', '', '', '2019-04-27 15:57:09.748752', 0, 0, 11);
INSERT INTO `recruitment_positioninfo` VALUES (12, '编辑', '内容编辑', '文案编辑', '全职', 5, 6, '南宁', '应届毕业生', '本科', '热爱搜集。热爱堆糖', '<span style=\"color:#333333;font-family:arial, 宋体, sans-serif;font-size:14px;background-color:#F6F4EC;\">堆糖从2011已经积累了30万优质用户和海量的优质内容，每个月保持 25-30% 的增长率，是目前国内最大的基于兴趣图谱的视觉</span><a target=\"_blank\" href=\"https://baike.baidu.com/item/%E7%A4%BE%E4%BA%A4%E7%BD%91%E7%AB%99\">社交网站</a><span style=\"color:#333333;font-family:arial, 宋体, sans-serif;font-size:14px;background-color:#F6F4EC;\">。而堆糖的注册用户主要来自</span><a target=\"_blank\" href=\"https://baike.baidu.com/item/%E7%A4%BE%E4%BC%9A%E5%8C%96\">社会化</a><span style=\"color:#333333;font-family:arial, 宋体, sans-serif;font-size:14px;background-color:#F6F4EC;\">媒体和用户口碑传播，构成比较多样化，活跃度也相对更高。</span>', '南宁江南区', '1234569@qq.com', '108.345139', '22.790595', '2019-04-27 16:22:04.741622', 0, 0, 12);
INSERT INTO `recruitment_positioninfo` VALUES (13, '财务', '会计', '财务部', '全职', 12, 16, '北京', '3-5年', '本科', '成为客户长期、最佳、可信赖合作伙伴', '<div class=\"para\" style=\"font-size:14px;color:#333333;font-family:arial, 宋体, sans-serif;background-color:#F6F4EC;\">\n	思特奇公司运用电信业务系统软件开发和云计算技术方面的经验，推出符合客户需求的软件产品，形成了：\n</div>\n<div class=\"para\" style=\"font-size:14px;color:#333333;font-family:arial, 宋体, sans-serif;background-color:#F6F4EC;\">\n	分布式内存数据库系统<span class=\"sup--normal\" style=\"font-size:12px;line-height:0;vertical-align:baseline;color:#3366CC;\">&nbsp;[4]</span><a name=\"ref_[4]_20693035\"></a>&nbsp;\n</div>\n<div class=\"para\" style=\"font-size:14px;color:#333333;font-family:arial, 宋体, sans-serif;background-color:#F6F4EC;\">\n	电子渠道系统<span class=\"sup--normal\" style=\"font-size:12px;line-height:0;vertical-align:baseline;color:#3366CC;\">&nbsp;[5]</span><a name=\"ref_[5]_20693035\"></a>&nbsp;\n</div>\n<div class=\"para\" style=\"font-size:14px;color:#333333;font-family:arial, 宋体, sans-serif;background-color:#F6F4EC;\">\n	营销活动管理平台<span class=\"sup--normal\" style=\"font-size:12px;line-height:0;vertical-align:baseline;color:#3366CC;\">&nbsp;[6]</span><a name=\"ref_[6]_20693035\"></a>&nbsp;\n</div>\n<div class=\"para\" style=\"font-size:14px;color:#333333;font-family:arial, 宋体, sans-serif;background-color:#F6F4EC;\">\n	网上商城<span class=\"sup--normal\" style=\"font-size:12px;line-height:0;vertical-align:baseline;color:#3366CC;\">&nbsp;[7]</span><a name=\"ref_[7]_20693035\"></a>&nbsp;\n</div>\n<div class=\"para\" style=\"font-size:14px;color:#333333;font-family:arial, 宋体, sans-serif;background-color:#F6F4EC;\">\n	门户业务分析系统<span class=\"sup--normal\" style=\"font-size:12px;line-height:0;vertical-align:baseline;color:#3366CC;\">&nbsp;[8]</span><a name=\"ref_[8]_20693035\"></a>&nbsp;\n</div>\n<div class=\"para\" style=\"font-size:14px;color:#333333;font-family:arial, 宋体, sans-serif;background-color:#F6F4EC;\">\n	在线客服系统<span class=\"sup--normal\" style=\"font-size:12px;line-height:0;vertical-align:baseline;color:#3366CC;\">&nbsp;[9]</span><a name=\"ref_[9]_20693035\"></a>&nbsp;\n</div>\n<div class=\"para\" style=\"font-size:14px;color:#333333;font-family:arial, 宋体, sans-serif;background-color:#F6F4EC;\">\n	网上营业厅系统<span class=\"sup--normal\" style=\"font-size:12px;line-height:0;vertical-align:baseline;color:#3366CC;\">&nbsp;[10]</span><a name=\"ref_[10]_20693035\"></a>&nbsp;\n</div>\n<div class=\"para\" style=\"font-size:14px;color:#333333;font-family:arial, 宋体, sans-serif;background-color:#F6F4EC;\">\n	手机营业厅<span class=\"sup--normal\" style=\"font-size:12px;line-height:0;vertical-align:baseline;color:#3366CC;\">&nbsp;[11]</span><a name=\"ref_[11]_20693035\"></a>&nbsp;\n</div>\n<div class=\"para\" style=\"font-size:14px;color:#333333;font-family:arial, 宋体, sans-serif;background-color:#F6F4EC;\">\n	电子渠道运营管理平台<span class=\"sup--normal\" style=\"font-size:12px;line-height:0;vertical-align:baseline;color:#3366CC;\">&nbsp;[12]</span><a name=\"ref_[12]_20693035\"></a>&nbsp;\n</div>\n<div class=\"para\" style=\"font-size:14px;color:#333333;font-family:arial, 宋体, sans-serif;background-color:#F6F4EC;\">\n	业务交付监控系统（SFM）<span class=\"sup--normal\" style=\"font-size:12px;line-height:0;vertical-align:baseline;color:#3366CC;\">&nbsp;[13]</span><a name=\"ref_[13]_20693035\"></a>&nbsp;\n</div>\n<div class=\"para\" style=\"font-size:14px;color:#333333;font-family:arial, 宋体, sans-serif;background-color:#F6F4EC;\">\n	CIC管理平台<span class=\"sup--normal\" style=\"font-size:12px;line-height:0;vertical-align:baseline;color:#3366CC;\">&nbsp;[14]</span><a name=\"ref_[14]_20693035\"></a>&nbsp;\n</div>\n<div class=\"para\" style=\"font-size:14px;color:#333333;font-family:arial, 宋体, sans-serif;background-color:#F6F4EC;\">\n	思特奇iRTMS (网络资源管理系统)<span class=\"sup--normal\" style=\"font-size:12px;line-height:0;vertical-align:baseline;color:#3366CC;\">&nbsp;[15]</span><a name=\"ref_[15]_20693035\"></a>&nbsp;\n</div>\n<div class=\"para\" style=\"font-size:14px;color:#333333;font-family:arial, 宋体, sans-serif;background-color:#F6F4EC;\">\n	移动容灾管理系统<span class=\"sup--normal\" style=\"font-size:12px;line-height:0;vertical-align:baseline;color:#3366CC;\">&nbsp;[16]</span><a name=\"ref_[16]_20693035\"></a>&nbsp;\n</div>\n<div class=\"para\" style=\"font-size:14px;color:#333333;font-family:arial, 宋体, sans-serif;background-color:#F6F4EC;\">\n	业务交付监控系统（SFM）<span class=\"sup--normal\" style=\"font-size:12px;line-height:0;vertical-align:baseline;color:#3366CC;\">&nbsp;[17]</span><a name=\"ref_[17]_20693035\"></a>&nbsp;\n</div>\n<div class=\"para\" style=\"font-size:14px;color:#333333;font-family:arial, 宋体, sans-serif;background-color:#F6F4EC;\">\n	营销资源管理系统（iRBMS）<span class=\"sup--normal\" style=\"font-size:12px;line-height:0;vertical-align:baseline;color:#3366CC;\">&nbsp;[18]</span><a name=\"ref_[18]_20693035\"></a>&nbsp;&nbsp;等多条产品线。\n</div>\n<div>\n	<br />\n</div>\n<div class=\"anchor-list\" style=\"color:#333333;font-family:arial, 宋体, sans-serif;font-size:12px;background-color:#F6F4EC;\">\n	<a name=\"3\"></a><a name=\"sub20693035_3\"></a><a name=\"发展目标\"></a>\n</div>\n<div class=\"para-title level-2\" style=\"font-size:22px;font-family:&quot;margin:35px 0px 15px -30px;background:url(&quot;color:#333333;\">\n</div>', '北京思特奇', '1234560@qq.com', '', '', '2019-04-27 16:25:24.226892', 0, 0, 13);
INSERT INTO `recruitment_positioninfo` VALUES (14, '销售', '销售专员', '销售部门', '全职', 8, 16, '北京', '应届毕业生', '大专', '弹性工作，节日福利', '<div class=\"para\" style=\"font-size:14px;color:#333333;font-family:arial, 宋体, sans-serif;background-color:#F6F4EC;\">\n	<span style=\"font-weight:700;\">Strategy 更优策略</span>\n</div>\n<div class=\"para\" style=\"font-size:14px;color:#333333;font-family:arial, 宋体, sans-serif;background-color:#F6F4EC;\">\n	优胜的策略是品牌营销得以制胜的王道，\n</div>\n<div class=\"para\" style=\"font-size:14px;color:#333333;font-family:arial, 宋体, sans-serif;background-color:#F6F4EC;\">\n	Golden-palm崇尚从实际出发，以科学为方法，以策略为先导，以创意制胜\n</div>\n<div class=\"para\" style=\"font-size:14px;color:#333333;font-family:arial, 宋体, sans-serif;background-color:#F6F4EC;\">\n	<span style=\"font-weight:700;\">Value更优价值</span>\n</div>\n<div class=\"para\" style=\"font-size:14px;color:#333333;font-family:arial, 宋体, sans-serif;background-color:#F6F4EC;\">\n	Golden-palm致力为客户量身打造真实有效的互动营销内容，\n</div>\n<div class=\"para\" style=\"font-size:14px;color:#333333;font-family:arial, 宋体, sans-serif;background-color:#F6F4EC;\">\n	为客户提供有真正互动营销价值的服务\n</div>\n<div class=\"para\" style=\"font-size:14px;color:#333333;font-family:arial, 宋体, sans-serif;background-color:#F6F4EC;\">\n	<span style=\"font-weight:700;\">Services 更具前瞻性</span>\n</div>\n<div class=\"para\" style=\"font-size:14px;color:#333333;font-family:arial, 宋体, sans-serif;background-color:#F6F4EC;\">\n	Golden-palm擅于深入发掘客户需求，\n</div>\n<div class=\"para\" style=\"font-size:14px;color:#333333;font-family:arial, 宋体, sans-serif;background-color:#F6F4EC;\">\n	为客户定制更具互动性、针对性的优质服务\n</div>', '北京海淀区中关村东路', '1234561@qq.com', '', '', '2019-04-27 16:29:40.533313', 0, 0, 14);
INSERT INTO `recruitment_positioninfo` VALUES (15, '行政', '助理', '业务经理', '全职', 8, 12, '上海', '1-3年', '本科', '工作轻松，专业简单', '<span style=\"color:#333333;font-family:arial;font-size:13px;background-color:rgba(230, 230, 230, 0.1);\">北京</span><span style=\"color:#CC0000;font-family:arial;font-size:13px;background-color:rgba(230, 230, 230, 0.1);\">博雅恒辉</span><span style=\"color:#333333;font-family:arial;font-size:13px;background-color:rgba(230, 230, 230, 0.1);\">咨询顾问有限公司关注人关注 未融资 | 公司介绍 北京</span><span style=\"color:#CC0000;font-family:arial;font-size:13px;background-color:rgba(230, 230, 230, 0.1);\">博雅恒辉</span><span style=\"color:#333333;font-family:arial;font-size:13px;background-color:rgba(230, 230, 230, 0.1);\">咨询顾问有限公司成立于2010年06月02日,主要经营范围为经济贸易咨询等。 ...</span>', '北京海淀区中关村东路', '1234562@qq.com', '', '', '2019-04-27 16:34:23.855654', 0, 0, 15);
INSERT INTO `recruitment_positioninfo` VALUES (16, '市场 / 营销', '市场营销', '市场营销部门', '全职', 6, 12, '北京', '1-3年', '本科', '推动影视文化发展', '<span style=\"color:#666666;font-family:&quot;font-size:14px;background-color:#F6F4EC;\">北京影合众新媒体技术服务有限公司成立于2010年，是一家专注于电影行业的软件及互联网创业公司，旨在为客户带来更好的观影体验和更高品质的网络服务。公司在经历3年的快速发展至今，已与多家知名国内院线行业客户有密切合作，如万达国际影城、星美国际影城等。&nbsp;</span><br />\n<span style=\"color:#666666;font-family:&quot;font-size:14px;background-color:#F6F4EC;\">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</span><br />\n<span style=\"color:#666666;font-family:&quot;font-size:14px;background-color:#F6F4EC;\">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;影合众出色的高级管理团队主创成员均为在IT行业、互联网行业巨头公司，如搜狐、雅虎中国等打拼、战斗过，又怀揣年轻创业梦想，不愿从众趋同的精英。所有员工皆为业务能力出色、事业心态良好的家园建设者。公司上下同欲，皆信奉客户至上的经营理念，和共建家园的企业文化。&nbsp;</span><br />\n<span style=\"color:#666666;font-family:&quot;font-size:14px;background-color:#F6F4EC;\">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</span><br />\n<span style=\"color:#666666;font-family:&quot;font-size:14px;background-color:#F6F4EC;\">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;公司对每一位员工的工作、生活十分关注，因此在提供五险一金、补充医疗、商业保险等各项保障之余，公司兼有轻松的工作氛围、舒适的办公环境、定期的专业培训、丰盛的下午茶餐、实用的健身课程等各项人文关怀，皆旨在使所有员工能对公司共建家园的企业文化有认同感，使每一个人用更顺畅的心情、更优越的生活来更好的全情投入工作，更好的服务客户，创造自身价值，放飞做创业人的梦想。</span>', '北京海淀区中关村东路', '1234563@qq.com', '', '', '2019-04-27 16:38:53.857675', 0, 0, 16);
INSERT INTO `recruitment_positioninfo` VALUES (17, '人力资源', '人事 / HR', '人力资源', '全职', 8, 12, '北京', '3-5年', '本科', '专门筛选人才', '<span style=\"font-size:14px;background-color:#F6F4EC;color:#666666;font-family:&quot;\">北京影合众新媒体技术服务有限公司成立于2010年，是一家专注于电影行业的软件及互联网创业公司，旨在为客户带来更好的观影体验和更高品质的网络服务。公司在经历3年的快速发展至今，已与多家知名国内院线行业客户有密切合作，如万达国际影城、星美国际影城等。&nbsp;</span><br />\n<span style=\"font-size:14px;background-color:#F6F4EC;color:#666666;font-family:&quot;\">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</span><br />\n<span style=\"font-size:14px;background-color:#F6F4EC;color:#666666;font-family:&quot;\">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;影合众出色的高级管理团队主创成员均为在IT行业、互联网行业巨头公司，如搜狐、雅虎中国等打拼、战斗过，又怀揣年轻创业梦想，不愿从众趋同的精英。所有员工皆为业务能力出色、事业心态良好的家园建设者。公司上下同欲，皆信奉客户至上的经营理念，和共建家园的企业文化。&nbsp;</span><br />\n<span style=\"font-size:14px;background-color:#F6F4EC;color:#666666;font-family:&quot;\">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</span><br />\n<span style=\"font-size:14px;background-color:#F6F4EC;color:#666666;font-family:&quot;\">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;公司对每一位员工的工作、生活十分关注，因此在提供五险一金、补充医疗、商业保险等各项保障之余，公司兼有轻松的工作氛围、舒适的办公环境、定期的专业培训、丰盛的下午茶餐、实用的健身课程等各项人文关怀，皆旨在使所有员工能对公司共建家园的企业文化有认同感，使每一个人用更顺畅的心情、更优越的生活来更好的全情投入工作，更好的服务客户，创造自身价值，放飞做创业人的梦想。</span>', '北京海淀区中关村东路', '1234563@qq.com', '', '', '2019-04-27 16:40:54.067666', 0, 0, 16);
INSERT INTO `recruitment_positioninfo` VALUES (18, '运营', '活动运营', '运营部门', '全职', 7, 10, '上海', '1-3年', '不限', '只要有文采都可以来我们这', '<p>\n	暴走漫画\n</p>\n<p>\n	暴走大事件\n</p>\n<p>\n	暴走看啥片\n</p>', '北京海淀区中关村东路', '1347152542@qq.com', '', '', '2019-04-27 16:42:43.629382', 0, 0, 5);

-- ----------------------------
-- Table structure for recruitment_tagsort
-- ----------------------------
DROP TABLE IF EXISTS `recruitment_tagsort`;
CREATE TABLE `recruitment_tagsort`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 5 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of recruitment_tagsort
-- ----------------------------
INSERT INTO `recruitment_tagsort` VALUES (1, '薪酬激励');
INSERT INTO `recruitment_tagsort` VALUES (2, '员工福利');
INSERT INTO `recruitment_tagsort` VALUES (3, '员工关怀');
INSERT INTO `recruitment_tagsort` VALUES (4, '其他');

SET FOREIGN_KEY_CHECKS = 1;
