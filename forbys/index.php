<?php
//соеденение с MySQL
$link = mysqli_connect("localhost", "root", "root", "forbys");

if ($link == false){
    exit("Ошибка: Невозможно подключиться к MySQL " . mysqli_connect_error());
}


//функция, отображающая основную страницу
function showEnterPage() {
	global $org, $link;
	?>

	<!DOCTYPE html>
	<html>
	<head>
		<link href="/cl/style.css" rel="stylesheet" type="text/css" />
		<title><?= $org['name'] . " : Форбис" ?></title>

  		<script src="cl/jquery-3.7.1.min.js" ></script>
  		<script>
			history.pushState(null, null, '/<?= $org['url'] ?>');

			$("document").ready (function() {
					$('.status_checkbox').click(function(){
					    $.post('/actions.php', {action : this.name, is_checked : this.checked, not_id : $(this).attr("data-not_id"), org_id : <?= $org[id] ?>})
					});
				}
			)
  		</script>
	</head>
	<body>
		<h3><?= $org['name'] ?></h3><form action="/" method="POST"><input type="hidden" name="action" value="exit"><button>Выйти</button></form>
		<h3>Уведомления</h3>
		<?php

		//вывод списка уведомлений организации
		$sql = 'SELECT tb_notifications.`id`, tb_notifications.`name`, tb_notifications.`text` FROM tb_notifications JOIN tb_nots_vs_orgs ON tb_notifications.id=tb_nots_vs_orgs.not_id WHERE tb_nots_vs_orgs.org_id = '. $org[id];

		$result = mysqli_query($link, $sql);
		if ($result) {
			while ($not = mysqli_fetch_array($result)) {
				?>
				<div class="notification">
					<h3><?= $not['name'] ?></h3>
					<span class="notification_text"><?= $not['text'] ?></span>
					<div class="actions">
						<input class="status_checkbox" type="checkbox" name="is_readed" data-not_id="<?= $not['id'] ?>" id="is_readed<?= $not[id] ?>"><label for="is_readed<?= $not[id] ?>"> ознакомлены</label><br>
						<input class="status_checkbox" type="checkbox" name="is_worked" data-not_id="<?= $not['id'] ?>" id="is_worked<?= $not[id] ?>"><label for="is_worked<?= $not[id] ?>"> отработали</label>
					</div>
				</div>
				<br>


				<?php
			}
		}


		?>
	</body>
	</html>			

	<?php
}

//ВЫХОД ИЗ СЕССИИ

if ($_POST['action'] == "exit") {
	setcookie('sk', null, -1, '/');
} else 
//проверяем сессию
if (preg_match('/^[a-f0-9]{32}$/ui', $_COOKIE['sk'])) {
	$sql = 'SELECT `org_id`, `id` FROM `tb_sessions` WHERE `session_key` ="'.$_COOKIE['sk'].'"';;
	$result = mysqli_query($link, $sql);
	if ($session_info = mysqli_fetch_array($result)) {
        $sql = 'SELECT `name`, `id`, `url` FROM `tb_organizations` WHERE `id` = "'.$session_info['org_id'].'"';
	
		$result = mysqli_query($link, $sql);
		if ($result) {
				//если вход удался
				if ($org = mysqli_fetch_array($result)) {
				showEnterPage();
				exit();
			}
		}
    }
}


//если передается пароль для входа, то проверяем его и входим в систему, создаем сессию
$salt = '!.asd\asdwsa<<a';
$uncorrect_password = false;

if ($_POST["password"]) {
	$sql = 'SELECT `name`, `id`, `url` FROM `tb_organizations` WHERE `password` ="'.$_POST['password'].'" AND `id` = "'.$_POST['org_id'].'"';
	
	$result = mysqli_query($link, $sql);
	if ($result) {
		//если вход удался
		if ($org = mysqli_fetch_array($result)) {
		showEnterPage();

		//создаем сессию
		$key = md5(time() . $salt . $org['id']);
        //$atime = time() + SETTINGS::$seesion_time;
        //DataBase::insert('tb_user_sessions', array('key' => $key, 'user_id' => $this->user_info['id'], 'assign_time' => $atime));
        $sql = 'INSERT tb_sessions(`session_key`, `org_id`) VALUES ("'.$key.'", '.$org[id].')';

		$result = mysqli_query($link, $sql);


        setcookie('sk', $key, time()+3600*24*360, '/');

		exit();

		//если вход не удался
		} else {
			$uncorrect_password = true;
		}
	}
}

//ЕСЛИ ВХОДА НЕ БЫЛО
//Вывод списка организаций
$sql = 'SELECT `name`, `id` FROM `tb_organizations`';
$result = mysqli_query($link, $sql);
?>
<!DOCTYPE html>
<html>
<head>
	<link href="/cl/style.css" rel="stylesheet" type="text/css" />
	<title>Форбис</title>
</head>
<body>
	<h2>Forbys.ru</h2>
	<h3>Организационная среда</h3>
	<h3>МКУ «Центр образования Нукутского района»</h3>
	<?= $uncorrect_password? "<span class='error'>Неверный пароль!</span><br><br>":"" ?> 
	<form action="" method="POST">
		<label for="orgs" class="field_desc">Организация:</label> 
		<select id="orgs" name="org_id" class="field">		
			<option value=""></option>
<?php

	while ($org = mysqli_fetch_array($result)) {
	  		
	  		echo "<option value=".$org['id'].">".$org['name']."</option>";
	}

?>

		</select><br><br>
		<label for="password" class="field_desc">Пароль:</label>
		<input id="password" type="password" name="password" class="field" autocomplete="current-password" /><br><br>
		<button>Войти</button>
	</form>

</body>
</html>

