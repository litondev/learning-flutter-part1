class Validation {
  String? validatePassword(String? value){
    if(value != null && value.length < 4){
      return "Password Minimal 4 Karakter";
    }

    return null;
  }

  String? validateEmail(String? value){
    if(value != null && value.contains('@')){
      return "Email tidak valid";
    }
    return null;
  }

  String? validateName(String? value){
    if(value != null && value.isEmpty){
      return "Nama harus diisi";
    }

    return null;
  }
}