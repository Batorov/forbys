<?php

echo "ss";

//соеденение с MySQL
$link = mysqli_connect("localhost", "root", "root", "forbys");

if ($link == false){
    exit("Ошибка: Невозможно подключиться к MySQL " . mysqli_connect_error());
}


if ($_POST["action"] == "is_readed") {
	$sql = 'UPDATE tb_nots_vs_orgs SET  `is_readed` = '.$_POST["is_checked"]=='true'? 1 : 0.' WHERE not_id = '.$_POST["not_id"]. ' AND org_id = ' . $_POST["org_id"];
	$result = mysqli_query($link, $sql);
}
