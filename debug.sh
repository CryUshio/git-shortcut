#! /bin/bash

getBranchs() {
  result=' charmia_20190816_suicai                                         
 charmia_20190823_sendMessage                                    
 charmia_20190829_9303_wxClassRate                               
 charmia_201909_institution                                      
 charmiachen_20190612_npc                                        
 charmiachen_201906_institution_manager                          
 charmiachen_voiceUpload                                         
 charry_20190513_adPay                                           
 charry_20190725_courseTable                                     
 charry_20191119_newCourse                                       
 charry_20191223_abc_pay_qrcode                                  
 charry_20191231_chatRecord                                      
 charry_20200107_dashboard                                       
 charry_20200115_modify_wx                                       
 charry_20200116_campData                                        
 charry_20200206_exportExcel'

  result=$(printf '%s' "${result}" | sed "s/^[* ] //g" | sed "s/remotes\/origin\///g" | sed "/HEAD/d")

  if [[ "$result" == *'fatal'* ]]; then
    echo ''
  else
    echo "$(printf '%s\n' "${result[@]}" | sort | uniq)"
  fi
}

echo `getBranchs | grep "$1"`