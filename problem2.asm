; =====================================================================
; Machine Problem 2 — Dungeon Adventure and Survival Game
; NASM 32-bit Assembly for Linux (int 0x80)
; =====================================================================

section .data
   ; Welcome ASCII Art & Messages
   welcome_banner db 0x0A, "=======================================", 0x0A, \
                  "       DUNGEON OF THE LOST KING", 0x0A, \
                  "=======================================", 0x0A, \
                  "              |>>>>", 0x0A, \
                  "              |", 0x0A, \
                  "              |", 0x0A, \
                  "          _  _|_  _", 0x0A, \
                  "         |;|_;|_;|;|", 0x0A, \
                  "         \ -   -  /", 0x0A, \
                  "          \:  .  /", 0x0A, \
                  "           ||:  |", 0x0A, \
                  "           ||:. |", 0x0A, \
                  "           ||: .|", 0x0A, \
                  "       ENTER IF YOU DARE!", 0x0A, \
                  "=======================================", 0x0A, 0
   welcome_len equ $ - welcome_banner

   prompt_name db "Enter your hero name: ", 0
   prompt_name_len equ $ - prompt_name

   prompt_class db 0x0A, "Choose your character:", 0x0A, \
                "[1] Warrior", 0x0A, \
                "[2] Mage", 0x0A, \
                "[3] Archer", 0x0A, \
                "Enter choice: ", 0
   prompt_class_len equ $ - prompt_class

   msg_welcome_hero db "Welcome, ", 0
   msg_welcome_hero_len equ $ - msg_welcome_hero
   msg_excl_nl db "!", 0x0A, 0
   msg_excl_nl_len equ $ - msg_excl_nl

   ; Main Menu
   main_menu_str db 0x0A, "=======================================", 0x0A, \
                 "             MAIN MENU", 0x0A, \
                 "=======================================", 0x0A, \
                 "[1] Explore Dungeon", 0x0A, \
                 "[2] View Character Status", 0x0A, \
                 "[3] Use Health Potion", 0x0A, \
                 "[4] View Inventory", 0x0A, \
                 "[5] Exit Game", 0x0A, \
                 "Enter choice: ", 0
   main_menu_len equ $ - main_menu_str

   ; Room 1: Goblin Chamber
   goblin_art db 0x0A, "       ,      ,", 0x0A, \
              '    /(.-""-.)\', 0x0A, \
              " |\  \/      \/  /|", 0x0A, \
              " | \ / =.  .= \ / |", 0x0A, \
              "  \  \   ^    /  /", 0x0A, \
              "   \  '-----'  /", 0x0A, \
              "A GOBLIN APPEARS!", 0x0A, 0
   goblin_art_len equ $ - goblin_art

   combat_menu db 0x0A, "[1] Attack  [2] Defend", 0x0A, \
               "[3] Use Potion  [4] Run", 0x0A, \
               "Enter combat choice: ", 0
   combat_menu_len equ $ - combat_menu

   ; Room 2: Treasure Chamber
   treasure_art db 0x0A, "     ____________", 0x0A, \
                "    /           /|", 0x0A, \
                "   /___________/ |", 0x0A, \
                "  |  _________  | |", 0x0A, \
                "  | |    ?    | | |", 0x0A, \
                "  | |_________| | /", 0x0A, \
                "  |_____________|/", 0x0A, \
                "You found a treasure chest!", 0x0A, \
                "[1] Open Chest  [2] Leave Chest", 0x0A, \
                "Enter choice: ", 0
   treasure_art_len equ $ - treasure_art

   msg_gain_gold db 0x0A, "Gained 50 gold!", 0x0A, 0
   msg_gain_gold_len equ $ - msg_gain_gold

   ; Room 3: Dragon's Lair
   dragon_art db 0x0A, "            / \  //\", 0x0A, \
              "     |\___/|   \", 0x0A, \
              "    /0   0 \   |", 0x0A, \
              "   /   ^    \  /", 0x0A, \
              "  /  \___/   \/", 0x0A, \
              " /___________\/", 0x0A, \
              "THE DRAGON AWAKENS!", 0x0A, 0
   dragon_art_len equ $ - dragon_art

   msg_enemy_hp db "Enemy Health: ", 0
   msg_enemy_hp_len equ $ - msg_enemy_hp

   msg_hero_hp_combat db "Your Health: ", 0
   msg_hero_hp_combat_len equ $ - msg_hero_hp_combat

   msg_victory db 0x0A, "VICTORY!", 0x0A, \
               "CONGRATULATIONS!", 0x0A, \
               "You defeated the dragon and escaped!", 0x0A, 0
   msg_victory_len equ $ - msg_victory

   msg_final_gold db "Final Gold: ", 0
   msg_final_gold_len equ $ - msg_final_gold

   msg_rem_hp db "Remaining Health: ", 0
   msg_rem_hp_len equ $ - msg_rem_hp

   msg_hero_title db "YOU ARE A HERO!", 0x0A, 0
   msg_hero_title_len equ $ - msg_hero_title

   msg_defeat  db 0x0A, "GAME OVER", 0x0A, \
               "Your hero has fallen.", 0x0A, \
               "The dungeon remains undefeated.", 0x0A, \
               "BETTER LUCK NEXT TIME!", 0x0A, 0
   msg_defeat_len equ $ - msg_defeat

   msg_status_hdr db 0x0A, "--- CHARACTER STATUS ---", 0x0A, 0
   msg_status_hdr_len equ $ - msg_status_hdr

   msg_lbl_name db "Hero Name: ", 0
   msg_lbl_name_len equ $ - msg_lbl_name

   msg_lbl_hp db "Health: ", 0
   msg_lbl_hp_len equ $ - msg_lbl_hp

   msg_slash db "/", 0
   msg_slash_len equ $ - msg_slash

   msg_lbl_atk db "Attack: ", 0
   msg_lbl_atk_len equ $ - msg_lbl_atk

   msg_inv_hdr db 0x0A, "--- INVENTORY ---", 0x0A, 0
   msg_inv_hdr_len equ $ - msg_inv_hdr

   msg_lbl_pots db "Potions: ", 0
   msg_lbl_pots_len equ $ - msg_lbl_pots

   msg_lbl_gold db "Gold: ", 0
   msg_lbl_gold_len equ $ - msg_lbl_gold

   msg_invalid db "Invalid selection. Try again.", 0x0A, 0
   msg_invalid_len equ $ - msg_invalid

   msg_no_potions db "Error; no health change (No potions remaining!)", 0x0A, 0
   msg_no_potions_len equ $ - msg_no_potions

   msg_pot_used db "Used a health potion! Health capped at maximum.", 0x0A, 0
   msg_pot_used_len equ $ - msg_pot_used

   msg_dungeon_cleared db 0x0A, "You have already completed the dungeon!", 0x0A, 0
   msg_dungeon_cleared_len equ $ - msg_dungeon_cleared

   str_warrior db "Warrior ", 0
   str_warrior_len equ $ - str_warrior
   str_mage db "Mage ", 0
   str_mage_len equ $ - str_mage
   str_archer db "Archer ", 0
   str_archer_len equ $ - str_archer

   newline db 0x0A, 0

section .bss
   hero_name        resb 32
   hero_name_len    resd 1
   class_choice     resb 4
   menu_choice      resb 4
   player_class_id  resd 1  ; 1=Warrior, 2=Mage, 3=Archer
   player_hp        resd 1
   player_max_hp    resd 1
   player_atk       resd 1
   player_pots      resd 1
   player_gold      resd 1
   current_room     resd 1  ; 0 = Room 1, 1 = Room 2, 2 = Room 3, 3 = Complete
   enemy_hp         resd 1
   defending        resd 1
   num_buf          resb 12

section .text
   global _start

_start:
   call display_welcome
   call get_player_info
   call initialize_character

main_loop:
   call display_main_menu
   mov eax, 3
   mov ebx, 0
   mov ecx, menu_choice
   mov edx, 4
   int 0x80

   movzx eax, byte [menu_choice]
   sub eax, '0'

   cmp eax, 1
   je do_explore
   cmp eax, 2
   je do_status
   cmp eax, 3
   je do_potion_menu
   cmp eax, 4
   je do_inventory
   cmp eax, 5
   je exit_program

   mov eax, 4
   mov ebx, 1
   mov ecx, msg_invalid
   mov edx, msg_invalid_len
   int 0x80
   jmp main_loop

do_explore:
   call explore_dungeon
   jmp main_loop

do_status:
   call display_status
   jmp main_loop

do_potion_menu:
   call use_potion
   jmp main_loop

do_inventory:
   call display_inventory
   jmp main_loop

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

get_player_info:
   mov eax, 4
   mov ebx, 1
   mov ecx, prompt_name
   mov edx, prompt_name_len
   int 0x80

   mov eax, 3
   mov ebx, 0
   mov ecx, hero_name
   mov edx, 32
   int 0x80
   mov [hero_name_len], eax

   cmp eax, 0
   je get_class_prompt
   mov ecx, eax
   dec ecx
   cmp byte [hero_name + ecx], 0x0A
   jne get_class_prompt
   mov byte [hero_name + ecx], 0

get_class_prompt:
   mov eax, 4
   mov ebx, 1
   mov ecx, prompt_class
   mov edx, prompt_class_len
   int 0x80

   mov eax, 3
   mov ebx, 0
   mov ecx, class_choice
   mov edx, 4
   int 0x80

   movzx eax, byte [class_choice]
   sub eax, '0'
   cmp eax, 1
   jl invalid_class
   cmp eax, 3
   jg invalid_class
   mov [player_class_id], eax
   ret

invalid_class:
   mov eax, 4
   mov ebx, 1
   mov ecx, msg_invalid
   mov edx, msg_invalid_len
   int 0x80
   jmp get_class_prompt

initialize_character:
   mov eax, [player_class_id]
   cmp eax, 1
   je init_warrior
   cmp eax, 2
   je init_mage
   cmp eax, 3
   je init_archer

init_warrior:
   mov dword [player_hp], 100
   mov dword [player_max_hp], 100
   mov dword [player_atk], 20
   mov dword [player_pots], 2
   jmp init_common

init_mage:
   mov dword [player_hp], 70
   mov dword [player_max_hp], 70
   mov dword [player_atk], 30
   mov dword [player_pots], 3
   jmp init_common

init_archer:
   mov dword [player_hp], 85
   mov dword [player_max_hp], 85
   mov dword [player_atk], 25
   mov dword [player_pots], 2
   jmp init_common

init_common:
   mov dword [player_gold], 0
   mov dword [current_room], 0
   mov dword [defending], 0

   mov eax, 4
   mov ebx, 1
   mov ecx, msg_welcome_hero
   mov edx, msg_welcome_hero_len
   int 0x80

   mov eax, [player_class_id]
   cmp eax, 1
   je print_cls_warrior
   cmp eax, 2
   je print_cls_mage

   mov eax, 4
   mov ebx, 1
   mov ecx, str_archer
   mov edx, str_archer_len
   int 0x80
   jmp print_hero_name

print_cls_warrior:
   mov eax, 4
   mov ebx, 1
   mov ecx, str_warrior
   mov edx, str_warrior_len
   int 0x80
   jmp print_hero_name

print_cls_mage:
   mov eax, 4
   mov ebx, 1
   mov ecx, str_mage
   mov edx, str_mage_len
   int 0x80

print_hero_name:
   mov eax, 4
   mov ebx, 1
   mov ecx, hero_name
   mov edx, [hero_name_len]
   int 0x80

   mov eax, 4
   mov ebx, 1
   mov ecx, msg_excl_nl
   mov edx, msg_excl_nl_len
   int 0x80
   ret

display_main_menu:
   mov eax, 4
   mov ebx, 1
   mov ecx, main_menu_str
   mov edx, main_menu_len
   int 0x80
   ret

explore_dungeon:
   mov eax, [current_room]
   cmp eax, 0
   je room_1_goblin
   cmp eax, 1
   je room_2_treasure
   cmp eax, 2
   je room_3_dragon
   cmp eax, 3
   je dungeon_completed
   ret

dungeon_completed:
   mov eax, 4
   mov ebx, 1
   mov ecx, msg_dungeon_cleared
   mov edx, msg_dungeon_cleared_len
   int 0x80
   ret

room_1_goblin:
   mov dword [enemy_hp], 30
   mov eax, 4
   mov ebx, 1
   mov ecx, goblin_art
   mov edx, goblin_art_len
   int 0x80
   call battle_enemy
   mov eax, [enemy_hp]
   cmp eax, 0
   jle advance_room_1
   ret

advance_room_1:
   mov dword [current_room], 1
   ret

room_2_treasure:
   mov eax, 4
   mov ebx, 1
   mov ecx, treasure_art
   mov edx, treasure_art_len
   int 0x80

   mov eax, 3
   mov ebx, 0
   mov ecx, menu_choice
   mov edx, 4
   int 0x80

   movzx eax, byte [menu_choice]
   sub eax, '0'
   cmp eax, 1
   je gain_gold
   jmp skip_gold

gain_gold:
   add dword [player_gold], 50

   ; Display Gold Gained
   mov eax, 4
   mov ebx, 1
   mov ecx, msg_gain_gold
   mov edx, msg_gain_gold_len
   int 0x80

skip_gold:
   mov dword [current_room], 2
   ret

room_3_dragon:
   mov dword [enemy_hp], 60
   mov eax, 4
   mov ebx, 1
   mov ecx, dragon_art
   mov edx, dragon_art_len
   int 0x80
   call battle_enemy
   mov eax, [enemy_hp]
   cmp eax, 0
   jle win_game
   ret

win_game:
   mov dword [current_room], 3
   call display_game_result
   ret

battle_enemy:
combat_loop:
   mov eax, [enemy_hp]
   cmp eax, 0
   jle combat_won
   mov eax, [player_hp]
   cmp eax, 0
   jle combat_lost

   ; Display Player Health
   mov eax, 4
   mov ebx, 1
   mov ecx, msg_hero_hp_combat
   mov edx, msg_hero_hp_combat_len
   int 0x80

   mov eax, [player_hp]
   cmp eax, 0
   jge print_php
   mov eax, 0
print_php:
   call print_number

   mov eax, 4
   mov ebx, 1
   mov ecx, msg_slash
   mov edx, msg_slash_len
   int 0x80

   mov eax, [player_max_hp]
   call print_number

   mov eax, 4
   mov ebx, 1
   mov ecx, newline
   mov edx, 1
   int 0x80

   ; Display Enemy Health
   mov eax, 4
   mov ebx, 1
   mov ecx, msg_enemy_hp
   mov edx, msg_enemy_hp_len
   int 0x80

   mov eax, [enemy_hp]
   cmp eax, 0
   jge print_ehp
   mov eax, 0
print_ehp:
   call print_number

   mov eax, 4
   mov ebx, 1
   mov ecx, newline
   mov edx, 1
   int 0x80

   ; Display Combat Menu
   mov eax, 4
   mov ebx, 1
   mov ecx, combat_menu
   mov edx, combat_menu_len
   int 0x80

   mov eax, 3
   mov ebx, 0
   mov ecx, menu_choice
   mov edx, 4
   int 0x80

   movzx eax, byte [menu_choice]
   sub eax, '0'
   cmp eax, 1
   je cmd_attack
   cmp eax, 2
   je cmd_defend
   cmp eax, 3
   je cmd_potion
   cmp eax, 4
   je cmd_run

   mov eax, 4
   mov ebx, 1
   mov ecx, msg_invalid
   mov edx, msg_invalid_len
   int 0x80
   jmp combat_loop

cmd_attack:
   mov eax, [player_atk]
   sub [enemy_hp], eax
   mov dword [defending], 0
   jmp enemy_turn

cmd_defend:
   mov dword [defending], 1
   jmp enemy_turn

cmd_potion:
   call use_potion
   jmp combat_loop

cmd_run:
   ret

enemy_turn:
   mov eax, [enemy_hp]
   cmp eax, 0
   jle combat_won

   mov ecx, [current_room]
   cmp ecx, 2
   je dragon_damage
   mov edx, 10
   jmp apply_damage

dragon_damage:
   mov edx, 15

apply_damage:
   mov eax, [defending]
   cmp eax, 1
   jne take_full_damage
   sub edx, 5
   cmp edx, 0
   jge take_full_damage
   mov edx, 0

take_full_damage:
   sub [player_hp], edx
   mov eax, [player_hp]
   cmp eax, 0
   jle combat_lost
   jmp combat_loop

combat_won:
   ret

combat_lost:
   call display_game_result
   ret

use_potion:
   mov eax, [player_pots]
   cmp eax, 0
   jle no_potions

   dec dword [player_pots]
   add dword [player_hp], 20

   mov eax, [player_max_hp]
   cmp [player_hp], eax
   jle potion_done
   mov [player_hp], eax

potion_done:
   mov eax, 4
   mov ebx, 1
   mov ecx, msg_pot_used
   mov edx, msg_pot_used_len
   int 0x80
   ret

no_potions:
   mov eax, 4
   mov ebx, 1
   mov ecx, msg_no_potions
   mov edx, msg_no_potions_len
   int 0x80
   ret

display_status:
   mov eax, 4
   mov ebx, 1
   mov ecx, msg_status_hdr
   mov edx, msg_status_hdr_len
   int 0x80

   mov eax, 4
   mov ebx, 1
   mov ecx, msg_lbl_name
   mov edx, msg_lbl_name_len
   int 0x80

   mov eax, 4
   mov ebx, 1
   mov ecx, hero_name
   mov edx, [hero_name_len]
   int 0x80

   mov eax, 4
   mov ebx, 1
   mov ecx, newline
   mov edx, 1
   int 0x80

   mov eax, 4
   mov ebx, 1
   mov ecx, msg_lbl_hp
   mov edx, msg_lbl_hp_len
   int 0x80

   mov eax, [player_hp]
   cmp eax, 0
   jge print_cur_hp
   mov eax, 0
print_cur_hp:
   call print_number

   mov eax, 4
   mov ebx, 1
   mov ecx, msg_slash
   mov edx, msg_slash_len
   int 0x80

   mov eax, [player_max_hp]
   call print_number

   mov eax, 4
   mov ebx, 1
   mov ecx, newline
   mov edx, 1
   int 0x80

   mov eax, 4
   mov ebx, 1
   mov ecx, msg_lbl_atk
   mov edx, msg_lbl_atk_len
   int 0x80

   mov eax, [player_atk]
   call print_number

   mov eax, 4
   mov ebx, 1
   mov ecx, newline
   mov edx, 1
   int 0x80
   ret

display_inventory:
   mov eax, 4
   mov ebx, 1
   mov ecx, msg_inv_hdr
   mov edx, msg_inv_hdr_len
   int 0x80

   mov eax, 4
   mov ebx, 1
   mov ecx, msg_lbl_pots
   mov edx, msg_lbl_pots_len
   int 0x80

   mov eax, [player_pots]
   call print_number

   mov eax, 4
   mov ebx, 1
   mov ecx, newline
   mov edx, 1
   int 0x80

   mov eax, 4
   mov ebx, 1
   mov ecx, msg_lbl_gold
   mov edx, msg_lbl_gold_len
   int 0x80

   mov eax, [player_gold]
   call print_number

   mov eax, 4
   mov ebx, 1
   mov ecx, newline
   mov edx, 1
   int 0x80
   ret

display_game_result:
   mov eax, [player_hp]
   cmp eax, 0
   jle show_defeat

   mov eax, 4
   mov ebx, 1
   mov ecx, msg_victory
   mov edx, msg_victory_len
   int 0x80

   mov eax, 4
   mov ebx, 1
   mov ecx, msg_final_gold
   mov edx, msg_final_gold_len
   int 0x80

   mov eax, [player_gold]
   call print_number

   mov eax, 4
   mov ebx, 1
   mov ecx, newline
   mov edx, 1
   int 0x80

   mov eax, 4
   mov ebx, 1
   mov ecx, msg_rem_hp
   mov edx, msg_rem_hp_len
   int 0x80

   mov eax, [player_hp]
   cmp eax, 0
   jge print_res_hp
   mov eax, 0
print_res_hp:
   call print_number

   mov eax, 4
   mov ebx, 1
   mov ecx, newline
   mov edx, 1
   int 0x80

   mov eax, 4
   mov ebx, 1
   mov ecx, msg_hero_title
   mov edx, msg_hero_title_len
   int 0x80
   jmp exit_program

show_defeat:
   mov eax, 4
   mov ebx, 1
   mov ecx, msg_defeat
   mov edx, msg_defeat_len
   int 0x80
   jmp exit_program

exit_program:
   mov eax, 1
   xor ebx, ebx
   int 0x80

; =====================================================================
; Utility Helper Functions
; =====================================================================
print_number:
   pusha
   mov ecx, num_buf + 11
   mov byte [ecx], 0
   mov ebx, 10

.convert_loop:
   xor edx, edx
   div ebx
   add dl, '0'
   dec ecx
   mov [ecx], dl
   test eax, eax
   jnz .convert_loop

   mov edx, num_buf + 11
   sub edx, ecx
   mov eax, 4
   mov ebx, 1
   int 0x80

   popa
   ret
