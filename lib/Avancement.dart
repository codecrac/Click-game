
class Avancement {

  int niveau;
  int objectif;
  int temps;

  Avancement(int niveau_fourni, int objectif_fourni, int temps_fourni){
    this.niveau = niveau_fourni;
    this.objectif = objectif_fourni;
    this.temps = temps_fourni;
  }

  Map<String,dynamic> convertirEnMap(){
    Map<String, dynamic> map = {
      'niveau' : this.niveau,
      'objectif' : this.objectif,
      'temps' : this.temps
    };
    return map;
  }

}