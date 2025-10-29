module iut.gon.test1 {
    requires javafx.controls;
    requires javafx.fxml;

    opens iut.gon.test1 to javafx.fxml;
    exports iut.gon.test1;
}
