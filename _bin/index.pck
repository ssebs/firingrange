GDPC                                                                               D   res://.import/crosshair.png-7bed3294e640fe9ca357247b0602b756.stex   �      �       e���kAH��V��Be��<   res://.import/icon.png-487276ed1e3a0c39cad0279d744ee560.stex�<      U      -��`�0��x�5�[$   res://Assets/crosshair.png.import          �      �lPM�o�9�aiC;,   res://Map.tscn  �      -      �h}g\��`�r��$�ރ   res://Scenes/Box.gd.remap   pL      %       
�������8.�hT   res://Scenes/Box.gdc�            x�p�0�L���#y�   res://Scenes/Box.tscn                ��f���J�l%��   res://Scenes/Bullet.gd.remap�L      (       V�MN!���6zb�w��N   res://Scenes/Bullet.gdc       >      ���z~iK��+Pv�^   res://Scenes/Bullet.tscnP      s      pv�6Қ�'��,-$   res://Scenes/Guns/TestGun.gd.remap  �L      .       �ŚC�B�䞂-c�    res://Scenes/Guns/TestGun.gdc   �            ݷF?k�x{�SZ��    res://Scenes/Guns/TestGun.tscn  �      r      -1cm�AS|�G��k�   res://Scenes/Player.gd.remap M      (       �	R��S��b�Ҷ?��@   res://Scenes/Player.gdc `*      �      ��mv�&���;Z�X�   res://Scenes/Player.tscn 6      �      ��O�F;��5tێ�   res://default_env.tres  �;      �       um�`�N��<*ỳ�8   res://icon.png  0M      �      G1?��z�c��vN��   res://icon.png.import   �I      �      �����%��(#AB�   res://project.binary Z      2      ��O�}�{y�8�K�            GDST                �   PNG �PNG

   IHDR           szz�   sRGB ���   9IDATX���9
  ������� -3m��  gd�)J�]����;��� ��	�ws��    IEND�B`� [remap]

importer="texture"
type="StreamTexture"
path="res://.import/crosshair.png-7bed3294e640fe9ca357247b0602b756.stex"
metadata={
"vram_texture": false
}

[deps]

source_file="res://Assets/crosshair.png"
dest_files=[ "res://.import/crosshair.png-7bed3294e640fe9ca357247b0602b756.stex" ]

[params]

compress/mode=0
compress/lossy_quality=0.7
compress/hdr_mode=0
compress/bptc_ldr=0
compress/normal_map=0
flags/repeat=0
flags/filter=true
flags/mipmaps=false
flags/anisotropic=false
flags/srgb=2
process/fix_alpha_border=true
process/premult_alpha=false
process/HDR_as_SRGB=false
process/invert_color=false
stream=false
size_limit=0
detect_3d=true
svg/scale=1.0
          [gd_scene load_steps=6 format=2]

[ext_resource path="res://Scenes/Box.tscn" type="PackedScene" id=1]
[ext_resource path="res://Scenes/Player.tscn" type="PackedScene" id=2]

[sub_resource type="BoxShape" id=1]
extents = Vector3( 5, 1, 20 )

[sub_resource type="CubeMesh" id=2]

[sub_resource type="SpatialMaterial" id=3]
albedo_color = Color( 0.0313726, 0.427451, 0.156863, 1 )

[node name="Map" type="Spatial"]

[node name="Floor" type="StaticBody" parent="."]
__meta__ = {
"_edit_group_": true,
"_edit_lock_": true
}

[node name="CollisionShape" type="CollisionShape" parent="Floor"]
shape = SubResource( 1 )

[node name="MeshInstance" type="MeshInstance" parent="Floor"]
transform = Transform( 5, 0, 0, 0, 1, 0, 0, 0, 20, 0, -1, 0 )
mesh = SubResource( 2 )
material/0 = SubResource( 3 )

[node name="BoxesGroup" type="Spatial" parent="."]

[node name="Box" parent="BoxesGroup" instance=ExtResource( 1 )]
transform = Transform( 1, 0, 0, 0, 1, 0, 0, 0, 1, 2.87572, 1.2, -18.3652 )

[node name="Box2" parent="BoxesGroup" instance=ExtResource( 1 )]
transform = Transform( 1, 0, 0, 0, 1, 0, 0, 0, 1, 0.0900607, 1.2, -18.3652 )

[node name="Box4" parent="BoxesGroup" instance=ExtResource( 1 )]
transform = Transform( 1, 0, 0, 0, 1, 0, 0, 0, 1, 1.44941, 3.24168, -18.3652 )

[node name="Box5" parent="BoxesGroup" instance=ExtResource( 1 )]
transform = Transform( 1, 0, 0, 0, 1, 0, 0, 0, 1, -1.35262, 3.24168, -18.3652 )

[node name="Box6" parent="BoxesGroup" instance=ExtResource( 1 )]
transform = Transform( 1, 0, 0, 0, 1, 0, 0, 0, 1, -0.0102173, 5.31489, -18.3652 )

[node name="Box3" parent="BoxesGroup" instance=ExtResource( 1 )]
transform = Transform( 1, 0, 0, 0, 1, 0, 0, 0, 1, -2.83573, 1.2, -18.3652 )

[node name="Player" parent="." instance=ExtResource( 2 )]
transform = Transform( 1, 0, 0, 0, 1, 0, 0, 0, 1, 0, 1.99305, 5.06382 )
   GDSC         	   $      ��������϶��   �����޶�   ���������¶�   ��Ѷ   ���϶���   ���������Ӷ�   d                                   	                        "   	   3YY;�  YY0�  P�  R�  QV�  �  �  �  &�  
�  V�  T�  PQY`        [gd_scene load_steps=5 format=2]

[ext_resource path="res://Scenes/Box.gd" type="Script" id=1]

[sub_resource type="BoxShape" id=1]

[sub_resource type="CubeMesh" id=2]

[sub_resource type="SpatialMaterial" id=3]
albedo_color = Color( 0.254902, 0.686275, 1, 1 )

[node name="Box" type="RigidBody"]
script = ExtResource( 1 )

[node name="CollisionShape" type="CollisionShape" parent="."]
shape = SubResource( 1 )

[node name="MeshInstance" type="MeshInstance" parent="."]
mesh = SubResource( 2 )
material/0 = SubResource( 3 )
   GDSC             �      ������ڶ   ������   ����򶶶   �������   Ѷ��   ��������   ��ڶ   ��������   ������������Ѷ��   �����϶�   ��������������ڶ   ���������������Ŷ���   ����׶��   ���������������۶���   ����Ŷ��   ̶��   ���������Ҷ�   ������¶   ��������۶��   �����ض�   �涶   ������¶   ���϶���   ���������Ҷ�   ���������¶�   ���������Ӷ�   ����������¶   
     {�G�z�?                
   bullet_hit                     	                              &   	   +   
   ,      -      3      :      ;      B      C      T      U      [      p      z      {      �      �      �      �      �      �      �      �      �       3YY8;�  Y8;�  Y8;�  �  YY;�  �  T�  �  Y;�  �  T�  Y;�  �  YYY0�	  PQV�  T�
  P�  QYY0�  P�  QV�  �  �  T�  T�  T�  T�  PQ�  �  �  �  �  �  �  T�  PT�  T�  �  T�  PQR�  T�  Q�  T�  T�  �  �  YY0�  P�  QV�  &�  V�  &�  T�  P�  QV�  �  T�  P�  RT�  Q�  �  �  �  T�  PQYY0�  PQV�  T�  PQY`  [gd_scene load_steps=5 format=2]

[ext_resource path="res://Scenes/Bullet.gd" type="Script" id=1]

[sub_resource type="CapsuleMesh" id=2]
radius = 0.05
mid_height = 0.1

[sub_resource type="SpatialMaterial" id=3]
albedo_color = Color( 0.964706, 0.721569, 0.258824, 1 )

[sub_resource type="CapsuleShape" id=1]
radius = 0.05
height = 0.1

[node name="Bullet" type="Spatial"]
script = ExtResource( 1 )

[node name="MeshInstance" type="MeshInstance" parent="."]
mesh = SubResource( 2 )
material/0 = SubResource( 3 )

[node name="Area" type="Area" parent="."]

[node name="CollisionShape" type="CollisionShape" parent="Area"]
shape = SubResource( 1 )

[node name="Timer" type="Timer" parent="."]
wait_time = 5.0
one_shot = true
autostart = true
[connection signal="body_entered" from="Area" to="." method="_on_hit"]
[connection signal="timeout" from="Timer" to="." method="_on_timeout"]
             GDSC            k      ������ڶ   ���������ض�   �ƶ�   ��������¶��   �ƶ�   ��������������Ķ   ��������¶��   ���������Ӷ�   ��������������Ѷ   ����¶��   ���������Ѷ�   Զ��   �������Ӷ���   ��������Ҷ��   ���������������۶���   ������   ����򶶶   ���϶���      res://Scenes/Bullet.tscn   
            2         Fire                                                 !   	   &   
   +      ,      2      :      <      =      F      M      U      [      a      b      i      3YYY5;�  ?PQY5;�  W�  Y5;�  W�  YY;�  �  Y;�  �  Y;�  �  YY0�	  PQV�  &�  T�
  PQV�  .�  �  ;�  �  T�  PQ�  �  T�  P�  Q�  �  T�  T�  �  �  T�  �  �  �  T�  �  �  �  �  T�  P�  QY`               [gd_scene load_steps=7 format=2]

[ext_resource path="res://Scenes/Guns/TestGun.gd" type="Script" id=1]

[sub_resource type="Animation" id=5]
resource_name = "Fire"
length = 0.3
tracks/0/type = "bezier"
tracks/0/path = NodePath(".:translation:x")
tracks/0/interp = 1
tracks/0/loop_wrap = true
tracks/0/imported = false
tracks/0/enabled = true
tracks/0/keys = {
"points": PoolRealArray( 0, -0.25, 0, 0.25, 0, 0, -0.25, 0, 0.25, 0, 0, -0.25, 0, 0.25, 0 ),
"times": PoolRealArray( 0, 0.14906, 0.3 )
}
tracks/1/type = "bezier"
tracks/1/path = NodePath(".:translation:y")
tracks/1/interp = 1
tracks/1/loop_wrap = true
tracks/1/imported = false
tracks/1/enabled = true
tracks/1/keys = {
"points": PoolRealArray( 0, -0.25, 0, 0.25, 0, 0.0680352, -0.25, 0, 0.25, 0, 0, -0.25, 0, 0.25, 0 ),
"times": PoolRealArray( 0, 0.14906, 0.3 )
}
tracks/2/type = "bezier"
tracks/2/path = NodePath(".:translation:z")
tracks/2/interp = 1
tracks/2/loop_wrap = true
tracks/2/imported = false
tracks/2/enabled = true
tracks/2/keys = {
"points": PoolRealArray( 0, -0.25, 0, 0.25, 0, 0.0473413, -0.25, 0, 0.25, 0, 0, -0.25, 0, 0.25, 0 ),
"times": PoolRealArray( 0, 0.14906, 0.3 )
}
tracks/3/type = "bezier"
tracks/3/path = NodePath(".:rotation_degrees:x")
tracks/3/interp = 1
tracks/3/loop_wrap = true
tracks/3/imported = false
tracks/3/enabled = true
tracks/3/keys = {
"points": PoolRealArray( 0, -0.25, 0, 0.25, 0, 21.55, -0.25, 0, 0.25, 0, 0, -0.25, 0, 0.25, 0 ),
"times": PoolRealArray( 0, 0.14906, 0.3 )
}
tracks/4/type = "bezier"
tracks/4/path = NodePath(".:rotation_degrees:y")
tracks/4/interp = 1
tracks/4/loop_wrap = true
tracks/4/imported = false
tracks/4/enabled = true
tracks/4/keys = {
"points": PoolRealArray( 0, -0.25, 0, 0.25, 0, 0, -0.25, 0, 0.25, 0, 0, -0.25, 0, 0.25, 0 ),
"times": PoolRealArray( 0, 0.14906, 0.3 )
}
tracks/5/type = "bezier"
tracks/5/path = NodePath(".:rotation_degrees:z")
tracks/5/interp = 1
tracks/5/loop_wrap = true
tracks/5/imported = false
tracks/5/enabled = true
tracks/5/keys = {
"points": PoolRealArray( 0, -0.25, 0, 0.25, 0, 0, -0.25, 0, 0.25, 0, 0, -0.25, 0, 0.25, 0 ),
"times": PoolRealArray( 0, 0.14906, 0.3 )
}

[sub_resource type="CubeMesh" id=1]
size = Vector3( 0.1, 0.1, 0.5 )

[sub_resource type="SpatialMaterial" id=3]
albedo_color = Color( 0.396078, 0.396078, 0.396078, 1 )

[sub_resource type="CubeMesh" id=2]
size = Vector3( 0.1, 0.3, 0.15 )

[sub_resource type="SpatialMaterial" id=4]
albedo_color = Color( 0.396078, 0.396078, 0.396078, 1 )

[node name="TestGun" type="Spatial"]
script = ExtResource( 1 )

[node name="FirePoint" type="Spatial" parent="."]
transform = Transform( 1, 0, 0, 0, 1, 0, 0, 0, 1, 0, 0, -0.299307 )

[node name="AnimationPlayer" type="AnimationPlayer" parent="."]
root_node = NodePath("../GunBody")
anims/Fire = SubResource( 5 )

[node name="GunBody" type="Spatial" parent="."]
transform = Transform( 1, 0, 0, 0, 1, 0, 0, 0, 1, 0, 0, 0 )

[node name="Barrel" type="MeshInstance" parent="GunBody"]
mesh = SubResource( 1 )
material/0 = SubResource( 3 )

[node name="Handle" type="MeshInstance" parent="GunBody"]
transform = Transform( 1, 0, 0, 0, 1, 0, 0, 0, 1, 0, -0.2, 0.15 )
mesh = SubResource( 2 )
material/0 = SubResource( 4 )
              GDSC   7      X   �     ������������϶��   �������   ����������������ﶶ�   �������������Ķ�   ����ڶ��   ����Ҷ��   ���ƶ���   ��������ض��   �������϶���   ���ڶ���   ��۶   ���Ҷ���   �����׶�   ���Ҷ���   ���Ҷ���   ���Ҷ���   ��������Ķ��   ����������¶   ��ض   ������ض   �����¶�   ����¶��   ����¶��   ����������������������Ҷ   �����������   ��������������������Ҷ��   �������������Ӷ�   �������������������   ���������������������Ҷ�   ������������������   ��������������������ض��   �������϶���   �������Ӷ���   ζ��   �������ζ���   ϶��   �������ض���   �������Ŷ���   ����׶��   ��������   ���Ӷ���   ���������������Ŷ���   ��������������¶   ����������Ŷ   ����������Ķ   ����������������Ҷ��   ��������۶��   ����Ŷ��   ̶��   ���������Ҷ�   �����������������Ӷ�   �������������Ӷ�   �涶   ����¶��   �������������Ӷ�  ������#@  �Q���?                
                  	   ui_cancel      F         jump      move_forward      move_backward      	   move_left      
   move_right        fire                                                    	   #   
   $      )      .      3      4      =      D      M      X      c      d      e      l      m      {      �      �      �      �      �      �      �       �   !   �   "   �   #   �   $   �   %   �   &   �   '   �   (   �   )   �   *     +     ,     -     .     /     0     1     2   "  3   (  4   )  5   *  6   3  7   ;  8   <  9   =  :   F  ;   L  <   M  =   N  >   W  ?   a  @   j  A   t  B   }  C   �  D   �  E   �  F   �  G   �  H   �  I   �  J   �  K   �  L   �  M   �  N   �  O   �  P   �  Q   �  R   �  S   �  T   �  U   �  V   �  W   �  X   3YY:�  Y8;�  �  YY;�  �  Y;�  �  Y;�  �  Y;�  �  YY;�  V�  Y;�  V�  Y;�	  V�  YY5;�
  W�  �  Y5;�  W�  Y5;�  W�  �  Y5;�  W�  �  �  Y5;�  W�  �  �  YYY0�  P�  QV�  �  &�  T�  P�  Q�  PQV�  �  T�  P�  T�  Q�  �  �  �  �  &�  T�  P�  Q�  PQV�  �  T�  P�  T�  Q�  �  �  �  �  �  &�  4�  �  PQV�  T�  P�+  P�  T�   T�!  �  QQ�  �  T�"  P�+  P�  T�   T�#  �  QQ�  �  T�$  T�!  �5  P�  T�$  T�!  R�+  P�  QR�+  P�  QQYYY0�%  P�&  QV�  &�  V�  �  T�'  PQ�  (V�  �  T�(  PQYY0�)  P�&  QV�  �*  P�&  Q�  �+  P�&  QYYY0�*  P�&  QV�  �  �  PQ�  �  �  &T�,  PQV�  �	  T�#  �  �&  �  �  �  &�  T�-  P�	  QV�  �	  T�#  �  �  �  �  &�  T�-  P�
  QV�  �  T�.  T�/  T�0  �  '�  T�-  P�  QV�  �  T�.  T�/  T�0  �  &�  T�-  P�  QV�  �  T�.  T�/  T�!  �  '�  T�-  P�  QV�  �  T�.  T�/  T�!  �  �  �  �  T�1  PQ�  �  �  T�2  P�  �  R�  �&  Q�  �  T�3  P�  R�  T�4  Q�  �3  P�	  R�  T�4  QYYY0�+  P�&  QV�  &�  T�  P�  QV�  �  T�5  PQYYYYYY0�  PQX�  V�  .�  T�6  PQ�  T�  YY`              [gd_scene load_steps=6 format=2]

[ext_resource path="res://Scenes/Player.gd" type="Script" id=1]
[ext_resource path="res://Scenes/Guns/TestGun.tscn" type="PackedScene" id=2]
[ext_resource path="res://Assets/crosshair.png" type="Texture" id=3]

[sub_resource type="CapsuleShape" id=1]
radius = 0.5
height = 1.5

[sub_resource type="CapsuleMesh" id=2]
radius = 0.5
mid_height = 1.5

[node name="Player" type="KinematicBody"]
script = ExtResource( 1 )

[node name="CollisionShape" type="CollisionShape" parent="."]
transform = Transform( 1, 0, 0, 0, -1.62921e-07, -1, 0, 1, -1.62921e-07, 0, 0, 0 )
shape = SubResource( 1 )

[node name="MeshInstance" type="MeshInstance" parent="."]
transform = Transform( 1, 0, 0, 0, -1.62921e-07, -1, 0, 1, -1.62921e-07, 0, 0, 0 )
visible = false
mesh = SubResource( 2 )
material/0 = null

[node name="Head" type="Spatial" parent="."]

[node name="Camera" type="Camera" parent="Head"]
transform = Transform( 1, 0, 0, 0, 1, 0, 0, 0, 1, 0, 0.680957, 0 )

[node name="TextureRect" type="TextureRect" parent="Head/Camera"]
anchor_left = 0.5
anchor_top = 0.5
anchor_right = 0.5
anchor_bottom = 0.5
margin_left = -20.0
margin_top = -20.0
margin_right = 20.0
margin_bottom = 20.0
texture = ExtResource( 3 )
stretch_mode = 4
__meta__ = {
"_edit_use_anchors_": false
}

[node name="Hand" type="Spatial" parent="Head"]
transform = Transform( 1, 0, 0, 0, 1, 0, 0, 0, 1, 0.418173, 0.406169, -0.685754 )

[node name="TestGun" parent="Head/Hand" instance=ExtResource( 2 )]
             [gd_resource type="Environment" load_steps=2 format=2]

[sub_resource type="ProceduralSky" id=1]

[resource]
background_mode = 2
background_sky = SubResource( 1 )
             GDST@   @           9  PNG �PNG

   IHDR   @   @   �iq�   sRGB ���  �IDATx�ݜytTU��?��WK*�=���%�  F����0N��݂:���Q�v��{�[�����E�ӋH���:���B�� YHB*d_*�jyo�(*M�JR!h��S�T��w�߻���ro���� N�\���D�*]��c����z��D�R�[�
5Jg��9E�|JxF׵'�a���Q���BH�~���!����w�A�b
C1�dB�.-�#��ihn�����u��B��1YSB<%�������dA�����C�$+(�����]�BR���Qsu][`
�DV����у�1�G���j�G͕IY! L1�]��� +FS�IY!IP ��|�}��*A��H��R�tQq����D`TW���p\3���M���,�fQ����d��h�m7r�U��f������.��ik�>O�;��xm��'j�u�(o}�����Q�S�-��cBc��d��rI�Ϛ�$I|]�ơ�vJkZ�9>��f����@EuC�~�2�ym�ش��U�\�KAZ4��b�4������;�X婐����@Hg@���o��W�b�x�)����3]j_��V;K����7�u����;o�������;=|��Ŗ}5��0q�$�!?��9�|�5tv�C�sHPTX@t����w�nw��۝�8�=s�p��I}�DZ-̝�ǆ�'�;=����R�PR�ۥu���u��ǻC�sH`��>�p�P ���O3R�������۝�SZ7 �p��o�P!�
��� �l��ހmT�Ƴێ�gA��gm�j����iG���B� ܦ(��cX�}4ۻB��ao��"����� ����G�7���H���æ;,NW?��[��`�r~��w�kl�d4�������YT7�P��5lF�BEc��=<�����?�:]�������G�Μ�{������n�v��%���7�eoݪ��
�QX¬)�JKb����W�[�G ��P$��k�Y:;�����{���a��&�eפ�����O�5,;����yx�b>=fc�* �z��{�fr��7��p���Ôִ�P����t^�]͑�~zs.�3����4��<IG�w�e��e��ih�/ˆ�9�H��f�?����O��.O��;!��]���x�-$E�a1ɜ�u�+7Ȃ�w�md��5���C.��\��X��1?�Nغ/�� ��~��<:k?8��X���!���[���꩓��g��:��E����>��꩓�u��A���	iI4���^v:�^l/;MC��	iI��TM-$�X�;iLH���;iI1�Zm7����P~��G�&g�|BfqV#�M������%��TM��mB�/�)����f����~3m`��������m�Ȉ�Ƽq!cr�pc�8fd���Mۨkl�}P�Л�汻��3p�̤H�>+���1D��i�aۡz�
������Z�Lz|8��.ִQ��v@�1%&���͏�������m���KH�� �p8H�4�9����/*)�aa��g�r�w��F36���(���7�fw����P��&�c����{﹏E7-f�M�).���9��$F�f r �9'1��s2).��G��{���?,�
�G��p�µ�QU�UO�����>��/�g���,�M��5�ʖ�e˃�d����/�M`�=�y=�����f�ӫQU�k'��E�F�+ =΂���
l�&���%%�������F#KY����O7>��;w���l6***B�g)�#W�/�k2�������TJ�'����=!Q@mKYYYdg��$Ib��E�j6�U�,Z�鼌Uvv6YYYԶ��}( ���ߠ#x~�s,X0�����rY��yz�	|r�6l����cN��5ϑ��KBB���5ϡ#xq�7�`=4A�o�xds)�~wO�z�^��m���n�Ds�������e|�0�u��k�ٱ:��RN��w�/!�^�<�ͣ�K1d�F����:�������ˣ����%U�Ą������l{�y����)<�G�y�`}�t��y!��O@� A� Y��sv:K�J��ՎۣQ�܃��T6y�ǯ�Zi
��<�F��1>�	c#�Ǉ��i�L��D�� �u�awe1�e&')�_�Ǝ^V�i߀4�$G�:��r��>h�hݝ������t;)�� &�@zl�Ұր��V6�T�+����0q��L���[t���N&e��Z��ˆ/����(�i啝'i�R�����?:
P].L��S��E�݅�Á�.a6�WjY$F�9P�«����V^7���1Ȓ� �b6�(����0"�k�;�@MC���N�]7 �)Q|s����QfdI���5 ��.f��#1���G���z���>)�N�>�L0T�ۘ5}��Y[�W뿼mj���n���S?�v��ْ|.FE"=�ߑ��q����������p����3�¬8�T�GZ���4ݪ�0�L�Y��jRH��.X�&�v����#�t��7y_#�[�o��V�O����^�����paV�&J�V+V��QY����f+m��(�?/������{�X��:�!:5�G�x���I����HG�%�/�LZ\8/����yLf�Æ>�X�Єǣq���$E������E�Ǣ�����gێ��s�rxO��x孏Q]n���LH����98�i�0==���O$5��o^����>6�a� �*�)?^Ca��yv&���%�5>�n�bŜL:��y�w���/��o�褨A���y,[|=1�VZ�U>,?͑���w��u5d�#�K�b�D�&�:�����l~�S\���[CrTV�$����y��;#�������6�y��3ݸ5��.�V��K���{�,-ւ� k1aB���x���	LL� ����ңl۱������!U��0L�ϴ��O\t$Yi�D�Dm��]|�m���M�3���bT�
�N_����~uiIc��M�DZI���Wgkn����C��!xSv�Pt�F��kڨ��������OKh��L����Z&ip��
ޅ���U�C�[�6��p���;uW8<n'n��nͽQ�
�gԞ�+Z	���{���G�Ĭ� �t�]�p;躆 ��.�ۣ�������^��n�ut�L �W��+ ���hO��^�w�\i� ��:9>3�=��So�2v���U1z��.�^�ߋěN���,���� �f��V�    IEND�B`�           [remap]

importer="texture"
type="StreamTexture"
path="res://.import/icon.png-487276ed1e3a0c39cad0279d744ee560.stex"
metadata={
"vram_texture": false
}

[deps]

source_file="res://icon.png"
dest_files=[ "res://.import/icon.png-487276ed1e3a0c39cad0279d744ee560.stex" ]

[params]

compress/mode=0
compress/lossy_quality=0.7
compress/hdr_mode=0
compress/bptc_ldr=0
compress/normal_map=0
flags/repeat=0
flags/filter=true
flags/mipmaps=false
flags/anisotropic=false
flags/srgb=2
process/fix_alpha_border=true
process/premult_alpha=false
process/HDR_as_SRGB=false
process/invert_color=false
stream=false
size_limit=0
detect_3d=true
svg/scale=1.0
[remap]

path="res://Scenes/Box.gdc"
           [remap]

path="res://Scenes/Bullet.gdc"
        [remap]

path="res://Scenes/Guns/TestGun.gdc"
  [remap]

path="res://Scenes/Player.gdc"
        �PNG

   IHDR   @   @   �iq�   sRGB ���  �IDATx��ytTU��?�ի%���@ȞY1JZ �iA�i�[P��e��c;�.`Ow+4�>�(}z�EF�Dm�:�h��IHHB�BR!{%�Zߛ?��	U�T�
���:��]~�������-�	Ì�{q*�h$e-
�)��'�d�b(��.�B�6��J�ĩ=;���Cv�j��E~Z��+��CQ�AA�����;�.�	�^P	���ARkUjQ�b�,#;�8�6��P~,� �0�h%*QzE� �"��T��
�=1p:lX�Pd�Y���(:g����kZx ��A���띊3G�Di� !�6����A҆ @�$JkD�$��/�nYE��< Q���<]V�5O!���>2<��f��8�I��8��f:a�|+�/�l9�DEp�-�t]9)C�o��M~�k��tw�r������w��|r�Ξ�	�S�)^� ��c�eg$�vE17ϟ�(�|���Ѧ*����
����^���uD�̴D����h�����R��O�bv�Y����j^�SN֝
������PP���������Y>����&�P��.3+�$��ݷ�����{n����_5c�99�fbסF&�k�mv���bN�T���F���A�9�
(.�'*"��[��c�{ԛmNު8���3�~V� az
�沵�f�sD��&+[���ke3o>r��������T�]����* ���f�~nX�Ȉ���w+�G���F�,U�� D�Դ0赍�!�B�q�c�(
ܱ��f�yT�:��1�� +����C|��-�T��D�M��\|�K�j��<yJ, ����n��1.FZ�d$I0݀8]��Jn_� ���j~����ցV���������1@M�)`F�BM����^x�>
����`��I�˿��wΛ	����W[�����v��E�����u��~��{R�(����3���������y����C��!��nHe�T�Z�����K�P`ǁF´�nH啝���=>id,�>�GW-糓F������m<P8�{o[D����w�Q��=N}�!+�����-�<{[���������w�u�L�����4�����Uc�s��F�륟��c�g�u�s��N��lu���}ן($D��ת8m�Q�V	l�;��(��ڌ���k�
s\��JDIͦOzp��مh����T���IDI���W�Iǧ�X���g��O��a�\:���>����g���%|����i)	�v��]u.�^�:Gk��i)	>��T@k{'	=�������@a�$zZ�;}�󩀒��T�6�Xq&1aWO�,&L�cřT�4P���g[�
p�2��~;� ��Ҭ�29�xri� ��?��)��_��@s[��^�ܴhnɝ4&'
��NanZ4��^Js[ǘ��2���x?Oܷ�$��3�$r����Q��1@�����~��Y�Qܑ�Hjl(}�v�4vSr�iT�1���f������(���A�ᥕ�$� X,�3'�0s����×ƺk~2~'�[�ё�&F�8{2O�y�n�-`^/FPB�?.�N�AO]]�� �n]β[�SR�kN%;>�k��5������]8������=p����Ցh������`}�
�J�8-��ʺ����� �fl˫[8�?E9q�2&������p��<�r�8x� [^݂��2�X��z�V+7N����V@j�A����hl��/+/'5�3�?;9
�(�Ef'Gyҍ���̣�h4RSS� ����������j�Z��jI��x��dE-y�a�X�/�����:��� +k�� �"˖/���+`��],[��UVV4u��P �˻�AA`��)*ZB\\��9lܸ�]{N��礑]6�Hnnqqq-a��Qxy�7�`=8A�Sm&�Q�����u�0hsPz����yJt�[�>�/ޫ�il�����.��ǳ���9��
_
��<s���wT�S������;F����-{k�����T�Z^���z�!t�۰؝^�^*���؝c
���;��7]h^
��PA��+@��gA*+�K��ˌ�)S�1��(Ե��ǯ�h����õ�M�`��p�cC�T")�z�j�w��V��@��D��N�^M\����m�zY��C�Ҙ�I����N�Ϭ��{�9�)����o���C���h�����ʆ.��׏(�ҫ���@�Tf%yZt���wg�4s�]f�q뗣�ǆi�l�⵲3t��I���O��v;Z�g��l��l��kAJѩU^wj�(��������{���)�9�T���KrE�V!�D���aw���x[�I��tZ�0Y �%E�͹���n�G�P�"5FӨ��M�K�!>R���$�.x����h=gϝ�K&@-F��=}�=�����5���s �CFwa���8��u?_����D#���x:R!5&��_�]���*�O��;�)Ȉ�@�g�����ou�Q�v���J�G�6�P�������7��-���	պ^#�C�S��[]3��1���IY��.Ȉ!6\K�:��?9�Ev��S]�l;��?/� ��5�p�X��f�1�;5�S�ye��Ƅ���,Da�>�� O.�AJL(���pL�C5ij޿hBƾ���ڎ�)s��9$D�p���I��e�,ə�+;?�t��v�p�-��&����	V���x���yuo-G&8->�xt�t������Rv��Y�4ZnT�4P]�HA�4�a�T�ǅ1`u\�,���hZ����S������o翿���{�릨ZRq��Y��fat�[����[z9��4�U�V��Anb$Kg������]������8�M0(WeU�H�\n_��¹�C�F�F�}����8d�N��.��]���u�,%Z�F-���E�'����q�L�\������=H�W'�L{�BP0Z���Y�̞���DE��I�N7���c��S���7�Xm�/`�	�+`����X_��KI��^��F\�aD�����~�+M����ㅤ��	SY��/�.�`���:�9Q�c �38K�j�0Y�D�8����W;ܲ�pTt��6P,� Nǵ��Æ�:(���&�N�/ X��i%�?�_P	�n�F�.^�G�E���鬫>?���"@v�2���A~�aԹ_[P, n��N������_rƢ��    IEND�B`�       ECFG      _global_script_classes             _global_script_class_icons             application/config/name         Firing Range   application/run/main_scene         res://Map.tscn     application/config/icon         res://icon.png     display/window/size/width            display/window/size/height      �     input/move_forward`              events              InputEventKey         resource_local_to_scene           resource_name             device            alt           shift             control           meta          command           pressed           scancode   W      unicode           echo          script            deadzone      ?   input/move_backward`              events              InputEventKey         resource_local_to_scene           resource_name             device            alt           shift             control           meta          command           pressed           scancode   S      unicode           echo          script            deadzone      ?   input/move_left`              events              InputEventKey         resource_local_to_scene           resource_name             device            alt           shift             control           meta          command           pressed           scancode   A      unicode           echo          script            deadzone      ?   input/move_right`              events              InputEventKey         resource_local_to_scene           resource_name             device            alt           shift             control           meta          command           pressed           scancode   D      unicode           echo          script            deadzone      ?
   input/jump`              events              InputEventKey         resource_local_to_scene           resource_name             device            alt           shift             control           meta          command           pressed           scancode          unicode           echo          script            deadzone      ?
   input/fire�              events              InputEventMouseButton         resource_local_to_scene           resource_name             device            alt           shift             control           meta          command           button_mask           position              global_position               factor       �?   button_index         pressed           doubleclick           script            deadzone      ?	   input/aim�              events              InputEventMouseButton         resource_local_to_scene           resource_name             device            alt           shift             control           meta          command           button_mask           position              global_position               factor       �?   button_index         pressed           doubleclick           script            deadzone      ?   input/interact`              events              InputEventKey         resource_local_to_scene           resource_name             device            alt           shift             control           meta          command           pressed           scancode   F      unicode           echo          script            deadzone      ?   input/sprint`              events              InputEventKey         resource_local_to_scene           resource_name             device            alt           shift             control           meta          command           pressed           scancode        unicode           echo          script            deadzone      ?$   rendering/quality/driver/driver_name         GLES2   %   rendering/vram_compression/import_etc         &   rendering/vram_compression/import_etc2          )   rendering/environment/default_environment          res://default_env.tres                