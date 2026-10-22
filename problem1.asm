; =====================================================================
; Machine Problem 1 — Zodiac Horoscope and Fortune Teller
; NASM 32-bit Assembly for Linux (int 0x80)
; =====================================================================

section .data
   ; Welcome Screen Banner (Matches image exact spacing/art)
   welcome_banner db 0x0A, "=======================================", 0x0A, \
                  "       THE MYSTIC ZODIAC ORACLE", 0x0A, \
                  "=======================================", 0x0A, \
                  "             *      *", 0x0A, \
                  "          *     /\     *", 0x0A, \
                  "               /  \ ", 0x0A, \
                  "         *    /____\    *", 0x0A, \
                  "               |  |", 0x0A, \
                  "          *    |__|    *", 0x0A, \
                  "       DISCOVER YOUR DESTINY!", 0x0A, \
                  "=======================================", 0x0A, 0
   welcome_len equ $ - welcome_banner

   ; Prompts
   prompt_name     db "Enter your name: ", 0
   prompt_name_len equ $ - prompt_name

   prompt_month     db "Enter birth month (1-12): ", 0
   prompt_month_len equ $ - prompt_month

   prompt_day     db "Enter birth day (1-31): ", 0
   prompt_day_len equ $ - prompt_day

   msg_welcome_user     db 0x0A, "Welcome, ", 0
   msg_welcome_user_len equ $ - msg_welcome_user

   msg_excl_nl     db "!", 0x0A, 0
   msg_excl_nl_len equ $ - msg_excl_nl

   msg_invalid_date     db 0x0A, "Invalid birth date entered! Please try again.", 0x0A, 0
   msg_invalid_date_len equ $ - msg_invalid_date

   ; Zodiac Header & Label Strings
   msg_zodiac_hdr     db 0x0A, "=======================================", 0x0A, \
                         "         YOUR ZODIAC SIGN", 0x0A, \
                         "=======================================", 0x0A, 0
   msg_zodiac_hdr_len equ $ - msg_zodiac_hdr

   lbl_sign     db "Zodiac Sign: ", 0
   lbl_sign_len equ $ - lbl_sign

   lbl_elem     db "Element: ", 0
   lbl_elem_len equ $ - lbl_elem

   lbl_sym      db "Symbol: ", 0
   lbl_sym_len  equ $ - lbl_sym

   lbl_desc     db "Personality: ", 0
   lbl_desc_len equ $ - lbl_desc

   ; Zodiac Data Strings
   str_capricorn db "CAPRICORN", 0
   str_cap_len   equ $ - str_capricorn
   str_aquarius  db "AQUARIUS", 0
   str_aqu_len   equ $ - str_aquarius
   str_pisces    db "PISCES", 0
   str_pis_len   equ $ - str_pisces
   str_aries     db "ARIES", 0
   str_ari_len   equ $ - str_aries
   str_taurus    db "TAURUS", 0
   str_tau_len   equ $ - str_taurus
   str_gemini    db "GEMINI", 0
   str_gem_len   equ $ - str_gemini
   str_cancer    db "CANCER", 0
   str_can_len   equ $ - str_cancer
   str_leo       db "LEO", 0
   str_leo_len   equ $ - str_leo
   str_virgo     db "VIRGO", 0
   str_vir_len   equ $ - str_virgo
   str_libra     db "LIBRA", 0
   str_lib_len   equ $ - str_libra
   str_scorpio   db "SCORPIO", 0
   str_sco_len   equ $ - str_scorpio
   str_sagittarius db "SAGITTARIUS", 0
   str_sag_len     equ $ - str_sagittarius

   str_fire      db "Fire", 0
   str_fire_len  equ $ - str_fire
   str_earth     db "Earth", 0
   str_earth_len equ $ - str_earth
   str_air       db "Air", 0
   str_air_len   equ $ - str_air
   str_water     db "Water", 0
   str_water_len equ $ - str_water

   str_sym_lion  db "Lion", 0
   str_sym_lion_len equ $ - str_sym_lion
   str_sym_ram   db "Ram", 0
   str_sym_ram_len equ $ - str_sym_ram

   desc_leo      db "Confident, creative, courageous.", 0
   desc_leo_len  equ $ - desc_leo
   desc_gen      db "Ambitious, resilient, and insightful.", 0
   desc_gen_len  equ $ - desc_gen

   ; ASCII Arts (Leo Lion art exact alignment from screenshot)
   art_leo       db "              /\_/\", 0x0A, \
                    "             ( o.o )", 0x0A, \
                    "              > ^ <", 0x0A, 0
   art_leo_len   equ $ - art_leo

   art_generic   db "              / \", 0x0A, \
                    "             /   \", 0x0A, \
                    "            /_____\", 0x0A, 0
   art_gen_len   equ $ - art_generic

   ; Horoscope Menu
   menu_str      db 0x0A, "---------------------------------------", 0x0A, \
                    "[1] Love and Relationships", 0x0A, \
                    "[2] Career and Studies", 0x0A, \
                    "[3] Health and Wellness", 0x0A, \
                    "[4] Lucky Number and Color", 0x0A, \
                    "[5] View Zodiac Information", 0x0A, \
                    "[6] Exit", 0x0A, \
                    "Enter your choice: ", 0
   menu_str_len  equ $ - menu_str

   prompt_return     db 0x0A, "Return to menu? (Y/N): ", 0
   prompt_return_len equ $ - prompt_return

   ; Predictions Text
   pred_love     db 0x0A, "--- LOVE & RELATIONSHIPS ---", 0x0A, \
                    "A surprise message from someone special will bring joy today.", 0x0A, \
                    "Stay open and communicate your feelings clearly!", 0x0A, 0
   pred_love_len equ $ - pred_love

   pred_career   db 0x0A, "--- CAREER & STUDIES ---", 0x0A, \
                    "Your creativity and focus will help you solve a difficult problem today.", 0x0A, \
                    "Stay focused and confident in your abilities!", 0x0A, 0
   pred_career_len equ $ - pred_career

   pred_health   db 0x0A, "--- HEALTH & WELLNESS ---", 0x0A, \
                    "Take a break and rest your mind. Hydrate well and recharge.", 0x0A, \
                    "A light walk will refresh your spirit!", 0x0A, 0
   pred_health_len equ $ - pred_health

   pred_lucky    db 0x0A, "--- LUCKY NUMBER & COLOR ---", 0x0A, \
                    "Lucky Number: 7", 0x0A, \
                    "Lucky Color : Gold & Royal Blue", 0x0A, 0
   pred_lucky_len equ $ - pred_lucky

   msg_invalid   db "Invalid selection. Try again.", 0x0A, 0
   msg_invalid_len equ $ - msg_invalid

   msg_goodbye   db 0x0A, "Thank you for consulting The Mystic Zodiac Oracle. Farewell!", 0x0A, 0
   msg_goodbye_len equ $ - msg_goodbye

   newline       db 0x0A, 0

section .bss
   user_name     resb 32
   user_name_len resd 1
   input_buf     resb 16
   birth_month   resd 1
   birth_day     resd 1
   zodiac_id     resd 1
   menu_choice   resb 4
   return_choice resb 4

section .text
   global _start

_start:
   call display_welcome

get_info_loop:
   call get_user_info
   call validate_birthdate
   cmp eax, 0
   je  invalid_date_entered
   jmp date_valid

invalid_date_entered:
   mov eax, 4
   mov ebx, 1
   mov ecx, msg_invalid_date
   mov edx, msg_invalid_date_len
   int 0x80
   jmp get_info_loop

date_valid:
   call determine_zodiac
   call display_zodiac_art

main_menu_loop:
   call display_menu
   
   mov eax, 3
   mov ebx, 0
   mov ecx, menu_choice
   mov edx, 4
   int 0x80

   movzx eax, byte [menu_choice]
   sub eax, '0'

   cmp eax, 6
   je exit_program

   cmp eax, 1
   jl invalid_menu_opt
   cmp eax, 5
   jg invalid_menu_opt

   call show_horoscope

ask_return:
   mov eax, 4
   mov ebx, 1
   mov ecx, prompt_return
   mov edx, prompt_return_len
   int 0x80

   mov eax, 3
   mov ebx, 0
   mov ecx, return_choice
   mov edx, 4
   int 0x80

   mov al, byte [return_choice]
   cmp al, 'Y'
   je main_menu_loop
   cmp al, 'y'
   je main_menu_loop
   cmp al, 'N'
   je exit_program
   cmp al, 'n'
   je exit_program
   jmp main_menu_loop

invalid_menu_opt:
   mov eax, 4
   mov ebx, 1
   mov ecx, msg_invalid
   mov edx, msg_invalid_len
   int 0x80
   jmp main_menu_loop

; =====================================================================
; Required Procedures
; =====================================================================

display_welcome:
   mov eax, 4
   mov ebx, 1
   mov ecx, welcome_banner
   mov edx, welcome_len
   int 0x80
   ret

get_user_info:
   mov eax, 4
   mov ebx, 1
   mov ecx, prompt_name
   mov edx, prompt_name_len
   int 0x80

   mov eax, 3
   mov ebx, 0
   mov ecx, user_name
   mov edx, 32
   int 0x80
   mov [user_name_len], eax

   cmp eax, 0
   je prompt_m
   mov ecx, eax
   dec ecx
   cmp byte [user_name + ecx], 0x0A
   jne prompt_m
   mov byte [user_name + ecx], 0

prompt_m:
   mov eax, 4
   mov ebx, 1
   mov ecx, prompt_month
   mov edx, prompt_month_len
   int 0x80

   mov eax, 3
   mov ebx, 0
   mov ecx, input_buf
   mov edx, 16
   int 0x80
   call parse_int
   mov [birth_month], eax

   mov eax, 4
   mov ebx, 1
   mov ecx, prompt_day
   mov edx, prompt_day_len
   int 0x80

   mov eax, 3
   mov ebx, 0
   mov ecx, input_buf
   mov edx, 16
   int 0x80
   call parse_int
   mov [birth_day], eax

   mov eax, 4
   mov ebx, 1
   mov ecx, msg_welcome_user
   mov edx, msg_welcome_user_len
   int 0x80

   mov eax, 4
   mov ebx, 1
   mov ecx, user_name
   mov edx, [user_name_len]
   int 0x80

   mov eax, 4
   mov ebx, 1
   mov ecx, msg_excl_nl
   mov edx, msg_excl_nl_len
   int 0x80
   ret

validate_birthdate:
   mov eax, [birth_month]
   cmp eax, 1
   jl val_failed
   cmp eax, 12
   jg val_failed

   mov ebx, [birth_day]
   cmp ebx, 1
   jl val_failed

   cmp eax, 2
   je check_feb
   cmp eax, 4
   je check_30
   cmp eax, 6
   je check_30
   cmp eax, 9
   je check_30
   cmp eax, 11
   je check_30

   cmp ebx, 31
   jg val_failed
   jmp val_success

check_feb:
   cmp ebx, 28
   jg val_failed
   jmp val_success

check_30:
   cmp ebx, 30
   jg val_failed

val_success:
   mov eax, 1
   ret

val_failed:
   mov eax, 0
   ret

determine_zodiac:
   mov eax, [birth_month]
   mov ebx, [birth_day]

   cmp eax, 1
   je m_jan
   cmp eax, 2
   je m_feb
   cmp eax, 3
   je m_mar
   cmp eax, 4
   je m_apr
   cmp eax, 5
   je m_may
   cmp eax, 6
   je m_jun
   cmp eax, 7
   je m_jul
   cmp eax, 8
   je m_aug
   cmp eax, 9
   je m_sep
   cmp eax, 10
   je m_oct
   cmp eax, 11
   je m_nov
   cmp eax, 12
   je m_dec

m_jan:
   cmp ebx, 19
   jle set_cap
   jmp set_aqu
m_feb:
   cmp ebx, 18
   jle set_aqu
   jmp set_pis
m_mar:
   cmp ebx, 20
   jle set_pis
   jmp set_ari
m_apr:
   cmp ebx, 19
   jle set_ari
   jmp set_tau
m_may:
   cmp ebx, 20
   jle set_tau
   jmp set_gem
m_jun:
   cmp ebx, 20
   jle set_gem
   jmp set_can
m_jul:
   cmp ebx, 22
   jle set_can
   jmp set_leo
m_aug:
   cmp ebx, 22
   jle set_leo
   jmp set_vir
m_sep:
   cmp ebx, 22
   jle set_vir
   jmp set_lib
m_oct:
   cmp ebx, 22
   jle set_lib
   jmp set_sco
m_nov:
   cmp ebx, 21
   jle set_sco
   jmp set_sag
m_dec:
   cmp ebx, 21
   jle set_sag
   jmp set_cap

set_cap: mov dword [zodiac_id], 1
         ret
set_aqu: mov dword [zodiac_id], 2
         ret
set_pis: mov dword [zodiac_id], 3
         ret
set_ari: mov dword [zodiac_id], 4
         ret
set_tau: mov dword [zodiac_id], 5
         ret
set_gem: mov dword [zodiac_id], 6
         ret
set_can: mov dword [zodiac_id], 7
         ret
set_leo: mov dword [zodiac_id], 8
         ret
set_vir: mov dword [zodiac_id], 9
         ret
set_lib: mov dword [zodiac_id], 10
         ret
set_sco: mov dword [zodiac_id], 11
         ret
set_sag: mov dword [zodiac_id], 12
         ret

display_zodiac_art:
   mov eax, 4
   mov ebx, 1
   mov ecx, msg_zodiac_hdr
   mov edx, msg_zodiac_hdr_len
   int 0x80

   mov eax, [zodiac_id]
   cmp eax, 8
   je print_leo_art

   mov eax, 4
   mov ebx, 1
   mov ecx, art_generic
   mov edx, art_gen_len
   int 0x80
   jmp print_zodiac_info

print_leo_art:
   mov eax, 4
   mov ebx, 1
   mov ecx, art_leo
   mov edx, art_leo_len
   int 0x80

print_zodiac_info:
   mov eax, 4
   mov ebx, 1
   mov ecx, lbl_sign
   mov edx, lbl_sign_len
   int 0x80

   mov eax, [zodiac_id]
   cmp eax, 1
   je p_cap
   cmp eax, 2
   je p_aqu
   cmp eax, 3
   je p_pis
   cmp eax, 4
   je p_ari
   cmp eax, 5
   je p_tau
   cmp eax, 6
   je p_gem
   cmp eax, 7
   je p_can
   cmp eax, 8
   je p_leo
   cmp eax, 9
   je p_vir
   cmp eax, 10
   je p_lib
   cmp eax, 11
   je p_sco

   mov ecx, str_sagittarius
   mov edx, str_sag_len
   jmp print_sign_str

p_cap: mov ecx, str_capricorn
       mov edx, str_cap_len
       jmp print_sign_str
p_aqu: mov ecx, str_aquarius
       mov edx, str_aqu_len
       jmp print_sign_str
p_pis: mov ecx, str_pisces
       mov edx, str_pis_len
       jmp print_sign_str
p_ari: mov ecx, str_aries
       mov edx, str_ari_len
       jmp print_sign_str
p_tau: mov ecx, str_taurus
       mov edx, str_tau_len
       jmp print_sign_str
p_gem: mov ecx, str_gemini
       mov edx, str_gem_len
       jmp print_sign_str
p_can: mov ecx, str_cancer
       mov edx, str_can_len
       jmp print_sign_str
p_leo: mov ecx, str_leo
       mov edx, str_leo_len
       jmp print_sign_str
p_vir: mov ecx, str_virgo
       mov edx, str_vir_len
       jmp print_sign_str
p_lib: mov ecx, str_libra
       mov edx, str_lib_len
       jmp print_sign_str
p_sco: mov ecx, str_scorpio
       mov edx, str_sco_len

print_sign_str:
   mov eax, 4
   mov ebx, 1
   int 0x80

   mov eax, 4
   mov ebx, 1
   mov ecx, newline
   mov edx, 1
   int 0x80

   mov eax, 4
   mov ebx, 1
   mov ecx, lbl_elem
   mov edx, lbl_elem_len
   int 0x80

   mov eax, [zodiac_id]
   cmp eax, 4
   je  p_fire
   cmp eax, 8
   je  p_fire
   cmp eax, 12
   je  p_fire

   cmp eax, 1
   je  p_earth
   cmp eax, 5
   je  p_earth
   cmp eax, 9
   je  p_earth

   cmp eax, 2
   je  p_air
   cmp eax, 6
   je  p_air
   cmp eax, 10
   je  p_air

   mov ecx, str_water
   mov edx, str_water_len
   jmp print_elem_str

p_fire:
   mov ecx, str_fire
   mov edx, str_fire_len
   jmp print_elem_str

p_earth:
   mov ecx, str_earth
   mov edx, str_earth_len
   jmp print_elem_str

p_air:
   mov ecx, str_air
   mov edx, str_air_len

print_elem_str:
   mov eax, 4
   mov ebx, 1
   int 0x80

   mov eax, 4
   mov ebx, 1
   mov ecx, newline
   mov edx, 1
   int 0x80

   mov eax, 4
   mov ebx, 1
   mov ecx, lbl_sym
   mov edx, lbl_sym_len
   int 0x80

   mov eax, [zodiac_id]
   cmp eax, 8
   je p_sym_lion

   mov ecx, str_sym_ram
   mov edx, str_sym_ram_len
   jmp print_sym_str

p_sym_lion:
   mov ecx, str_sym_lion
   mov edx, str_sym_lion_len

print_sym_str:
   mov eax, 4
   mov ebx, 1
   int 0x80

   mov eax, 4
   mov ebx, 1
   mov ecx, newline
   mov edx, 1
   int 0x80

   mov eax, 4
   mov ebx, 1
   mov ecx, lbl_desc
   mov edx, lbl_desc_len
   int 0x80

   mov eax, [zodiac_id]
   cmp eax, 8
   je p_desc_leo

   mov ecx, desc_gen
   mov edx, desc_gen_len
   jmp print_desc_str

p_desc_leo:
   mov ecx, desc_leo
   mov edx, desc_leo_len

print_desc_str:
   mov eax, 4
   mov ebx, 1
   int 0x80

   mov eax, 4
   mov ebx, 1
   mov ecx, newline
   mov edx, 1
   int 0x80
   ret

display_menu:
   mov eax, 4
   mov ebx, 1
   mov ecx, menu_str
   mov edx, menu_str_len
   int 0x80
   ret

show_horoscope:
   movzx eax, byte [menu_choice]
   sub eax, '0'

   cmp eax, 1
   je show_love
   cmp eax, 2
   je show_career
   cmp eax, 3
   je show_health
   cmp eax, 4
   je show_lucky
   cmp eax, 5
   je show_zodiac_info
   ret

show_love:
   mov eax, 4
   mov ebx, 1
   mov ecx, pred_love
   mov edx, pred_love_len
   int 0x80
   ret

show_career:
   mov eax, 4
   mov ebx, 1
   mov ecx, pred_career
   mov edx, pred_career_len
   int 0x80
   ret

show_health:
   mov eax, 4
   mov ebx, 1
   mov ecx, pred_health
   mov edx, pred_health_len
   int 0x80
   ret

show_lucky:
   mov eax, 4
   mov ebx, 1
   mov ecx, pred_lucky
   mov edx, pred_lucky_len
   int 0x80
   ret

show_zodiac_info:
   call display_zodiac_art
   ret

exit_program:
   mov eax, 4
   mov ebx, 1
   mov ecx, msg_goodbye
   mov edx, msg_goodbye_len
   int 0x80

   mov eax, 1
   xor ebx, ebx
   int 0x80

parse_int:
   push ebx
   push ecx
   mov esi, input_buf
   xor eax, eax
   xor ecx, ecx

.parse_loop:
   mov cl, byte [esi]
   cmp cl, '0'
   jl .parse_done
   cmp cl, '9'
   jg .parse_done
   sub cl, '0'
   imul eax, 10
   add eax, ecx
   inc esi
   jmp .parse_loop

.parse_done:
   pop ecx
   pop ebx
   ret