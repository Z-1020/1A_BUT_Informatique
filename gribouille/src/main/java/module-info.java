module iut.gon.Gribouille {
    requires javafx.controls;
    requires javafx.fxml;
	requires javafx.graphics;
	requires javafx.base;

    opens iut.gon.Gribouille to javafx.fxml;
    opens iut.gon.Gribouille.controleurs to javafx.fxml;
    exports iut.gon.Gribouille;
    exports iut.gon.Gribouille.controleurs to javafx.fxml;
}
