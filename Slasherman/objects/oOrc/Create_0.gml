/// @desc

//Movement vars
walkSpd = 0.3;

//Instance vars
damage = 2;
maxLife = 5;
knockback = 0.7;
knockbackJump = 3;
attackRange = 5;
coolDown = room_speed;

//Sprite vars
hitboxSprite = sOrcHitbox;
idleSprite = sOrcIdle;
walkingSprite = sOrcWalking;
attackingSprite= sOrcAttacking;
damagedSprite = sOrcDamaged;
deadSprite = sOrcDead;

event_inherited();