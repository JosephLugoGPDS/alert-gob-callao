
import 'dart:convert';


UserMoreInfo userMoreInfoFromJson(String str) => UserMoreInfo.fromJson(json.decode(str));

String userMoreInfoToJson(UserMoreInfo data) => json.encode(data.toJson());

class UserMoreInfo {
    UserMoreInfo({
        this.id ,
        // this.uid ,
        this.nombre,
        this.apellido,
        this.fijo,
        this.dni,
        this.direccion,
        this.distrito,
        this.fecha,
        this.respaldoName,
        this.respaldoTel,
    });

    String id;
    // String uid;
    String nombre;
    String apellido;
    int fijo;
    int dni;
    String direccion;
    String distrito;
    String fecha;
    String respaldoName;
    String respaldoTel;

    factory UserMoreInfo.fromJson(Map<String, dynamic> json) => UserMoreInfo(
        id          : json["id"],
        // uid         : json["uid"],
        nombre      : json["nombre"],
        apellido    : json["apellido"],
        fijo        : json["fijo"],
        dni         : json["dni"],
        direccion       :json["direccion"],
        distrito        :json["distrito"],
        fecha           :json["fecha"],
        respaldoName    :json["respaldoName"],
        respaldoTel     :json["respaldoTel"],
    );

    Map<String, dynamic> toJson() => {
        //"id"          : id,//evitar que el id se vuelva campo al actualizar
        //"uid"          : uid,
        "nombre"      : nombre,
        "apellido"    : apellido,
        "fijo"        : fijo,
        "dni"         : dni,
        "direccion "      :direccion,
        "distrito"        :distrito,
        "fecha"          :fecha,
        "respaldoName"    :respaldoName,
        "respaldoTel"     :respaldoTel,
    };
}