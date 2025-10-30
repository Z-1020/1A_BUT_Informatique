function commander(pla_num){
    console.log("Test")
    window.location.href = "page/commander.php?PLA_NUM=" + encodeURIComponent(pla_num);
}