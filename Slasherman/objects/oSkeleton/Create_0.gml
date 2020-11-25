/// @desc

//Movement vars
walkSpd = 0.5;

//Instance vars
damage = 1;
maxLife = 4;
knockback = 1;
knockbackJump = 3;
attackRange = 8;
coolDown = room_speed  / 2;

//Sprite vars
hitboxSprite = sSkeletonHitbox;
idleSprite = sSkeletonIdle;
walkingSprite = sSkeletonWalking;
attackingSprite= sSkeletonAttacking;
damagedSprite = sSkeletonDamaged;
deadSprite = sSkeletonDead;

event_inherited();