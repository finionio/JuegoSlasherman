/// @desc

walkSpd = 0.6;

jumpHeight = 4;
damage = 0.5;
maxLife = 2;
knockback = 1.5;
knockbackJump = 3;
attackRange = 10; //FAR
coolDown = room_speed / 3;

hitboxSprite = sSlimeHitbox;
idleSprite = sSlimeIdle;
walkingSprite = sSlimeWalking
attackingSprite = sSlimeAttacking;
damagedSprite = sSlimeDamaged;
deadSprite = sSlimeDead;

event_inherited();

parry = false;