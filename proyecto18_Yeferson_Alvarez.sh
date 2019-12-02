#!/bin/bash
##funcion de ayuda
function usage (){
	cat <<-EOF
usage: ${0} [-e r c i] user [username]
Deshabilitar una cuenta local de Linux.
-e Elimina cuentas en lugar de deshabilitarlas.
-r retirar/elimina el directorio de inicio asociado con la (s) cuenta (s).
-c Crea un archivo del directorio de inicio asociado con la (s) cuenta (s).
-i inhabilitar a un usuario pero no lo elimina.
	EOF
}
###si no funciona bien ###
if [[ "${UID}" -eq 0 ]]
then
	echo "tienes permisos"
		#comprovar si hay parametros
		if [ $# -eq 0 ];
		then
			echo "Pero no has indicado los parametros"
			usage
		else
			while getopts "e:r:c:i:/:*:?:" par;
			do
				case $par in
				e)
				user="${OPTARG}"
				userdel $user
				if [ $? -eq 0 ];
				then
					echo "El usuario ${user} se elimino de forma correcta"
				else
					echo "El usuario ${user} no se ha podido eliminar"
				fi
				;;
 
				r)
				user="${OPTARG}"
				rm -r /home/$user
				if [ $? -eq 0 ];
				then
					echo "Se retiro/elimino la carpeta del usuario ${user}"
				else
					echo "No se pudo retirar/eliminar la carpeta de ${user}"
				fi
				;;

				c)
				user="${OPTARG}"
				cp -r /home/$user /home/yef/Escritorio/Proyecto18_Yeferson/$user.tar
				if [ $? -eq 0 ];
				then
					echo "La copia de seguridad se hizo correctamente para ${user}"
				else
					echo "La copia de seguridad no se pudo hacer"
				fi
				;;

				i)
				user="${OPTARG}"
				usermod -L $user
				if [ $? -eq 0 ];
				then
					echo "El usuario ${user} ha sido inhabilitado"
				else
					echo "No se pudo inhabilitar el usuario"
				fi
				;;

				*)
				echo "Este parametro no es valido ${OPTARG}"
				usage
				;;

				/)
				echo "Este parametro no es valido ${OPTARG}"
                                usage
                                ;;

				?)
				echo "Ete parametro no es valido ${OPTARG}"
				usage
				;;
				esac
			done
		fi
else
	echo "No tienes permisos para ejecutar este script"
	echo "Ejecute este script con permisos de root"
fi
