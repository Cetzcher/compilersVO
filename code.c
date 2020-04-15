#include <stdio.h>
#include <stdlib.h>
#include <assert.h>
#define STATE_TYPE void*
#include "scope.h"
#include "instructions.h"

#define L(p)   	((p)->children[0])
#define R(p)    ((p)->children[1])

#include <limits.h>
#include <stdlib.h>
#ifndef STATE_TYPE
#define STATE_TYPE int
#endif
#ifndef ALLOC
#define ALLOC(n) malloc(n)
#endif
#ifndef burm_assert
#define burm_assert(x,y) if (!(x)) { y; abort(); }
#endif

#define burm_expr_NT 1
#define burm_const_NT 2
#define burm_varexpr_NT 3
int burm_max_nt = 3;

struct burm_state {
	int op;
	struct burm_state *left, *right;
	short cost[4];
	struct {
		unsigned burm_expr:2;
		unsigned burm_const:4;
		unsigned burm_varexpr:1;
	} rule;
};

static short burm_nts_0[] = { burm_const_NT, 0 };
static short burm_nts_1[] = { burm_varexpr_NT, 0 };
static short burm_nts_2[] = { 0 };
static short burm_nts_3[] = { burm_const_NT, burm_const_NT, 0 };

short *burm_nts[] = {
	0,	/* 0 */
	burm_nts_0,	/* 1 */
	burm_nts_1,	/* 2 */
	burm_nts_2,	/* 3 */
	burm_nts_3,	/* 4 */
	burm_nts_0,	/* 5 */
	burm_nts_3,	/* 6 */
	burm_nts_3,	/* 7 */
	burm_nts_0,	/* 8 */
	burm_nts_3,	/* 9 */
	burm_nts_3,	/* 10 */
	burm_nts_2,	/* 11 */
};

char burm_arity[] = {
	0,	/* 0=OP_NOP */
	2,	/* 1=OP_PLUS */
	1,	/* 2=OP_MINUS */
	0,	/* 3=OP_NUM */
	0,	/* 4=OP_VAR */
	0,	/* 5=OP_ZERO */
	0,	/* 6=OP_ONE */
	2,	/* 7=OP_MULT */
	2,	/* 8=OP_HASH */
	2,	/* 9=OP_LTEQ */
	2,	/* 10=OP_AND */
	1,	/* 11=OP_NOT */
};

static short burm_decode_expr[] = {
	0,
	1,
	2,
};

static short burm_decode_const[] = {
	0,
	3,
	4,
	5,
	6,
	7,
	8,
	9,
	10,
};

static short burm_decode_varexpr[] = {
	0,
	11,
};

int burm_rule(STATE_TYPE state, int goalnt) {
	burm_assert(goalnt >= 1 && goalnt <= 3, PANIC("Bad goal nonterminal %d in burm_rule\n", goalnt));
	if (!state)
		return 0;
	switch (goalnt) {
	case burm_expr_NT:	return burm_decode_expr[((struct burm_state *)state)->rule.burm_expr];
	case burm_const_NT:	return burm_decode_const[((struct burm_state *)state)->rule.burm_const];
	case burm_varexpr_NT:	return burm_decode_varexpr[((struct burm_state *)state)->rule.burm_varexpr];
	default:
		burm_assert(0, PANIC("Bad goal nonterminal %d in burm_rule\n", goalnt));
	}
	return 0;
}

static void burm_closure_const(struct burm_state *, int);
static void burm_closure_varexpr(struct burm_state *, int);

static void burm_closure_const(struct burm_state *p, int c) {
	if (c + 0 < p->cost[burm_expr_NT]) {
		p->cost[burm_expr_NT] = c + 0;
		p->rule.burm_expr = 1;
	}
}

static void burm_closure_varexpr(struct burm_state *p, int c) {
	if (c + 0 < p->cost[burm_expr_NT]) {
		p->cost[burm_expr_NT] = c + 0;
		p->rule.burm_expr = 2;
	}
}

STATE_TYPE burm_state(int op, STATE_TYPE left, STATE_TYPE right) {
	int c;
	struct burm_state *p, *l = (struct burm_state *)left,
		*r = (struct burm_state *)right;

	assert(sizeof (STATE_TYPE) >= sizeof (void *));
	if (burm_arity[op] > 0) {
		p = ALLOC(sizeof *p);
		burm_assert(p, PANIC("ALLOC returned NULL in burm_state\n"));
		p->op = op;
		p->left = l;
		p->right = r;
		p->rule.burm_expr = 0;
		p->cost[1] =
		p->cost[2] =
		p->cost[3] =
			32767;
	}
	switch (op) {
	case 0: /* OP_NOP */
		{
			static struct burm_state z = { 0, 0, 0,
				{	0,
					32767,
					32767,
					32767,
				},{
					0,
					0,
					0,
				}
			};
			return (STATE_TYPE)&z;
		}
	case 1: /* OP_PLUS */
		assert(l && r);
		if (	/* varexpr: OP_PLUS(OP_VAR,OP_VAR) */
			l->op == 4 && /* OP_VAR */
			r->op == 4 /* OP_VAR */
		) {
			c = 1;
			if (c + 0 < p->cost[burm_varexpr_NT]) {
				p->cost[burm_varexpr_NT] = c + 0;
				p->rule.burm_varexpr = 1;
				burm_closure_varexpr(p, c + 0);
			}
		}
		{	/* const: OP_PLUS(const,const) */
			c = l->cost[burm_const_NT] + r->cost[burm_const_NT] + 0;
			if (c + 0 < p->cost[burm_const_NT]) {
				p->cost[burm_const_NT] = c + 0;
				p->rule.burm_const = 2;
				burm_closure_const(p, c + 0);
			}
		}
		break;
	case 2: /* OP_MINUS */
		assert(l);
		{	/* const: OP_MINUS(const) */
			c = l->cost[burm_const_NT] + 0;
			if (c + 0 < p->cost[burm_const_NT]) {
				p->cost[burm_const_NT] = c + 0;
				p->rule.burm_const = 3;
				burm_closure_const(p, c + 0);
			}
		}
		break;
	case 3: /* OP_NUM */
		{
			static struct burm_state z = { 3, 0, 0,
				{	0,
					0,	/* expr: const */
					0,	/* const: OP_NUM */
					32767,
				},{
					1,	/* expr: const */
					1,	/* const: OP_NUM */
					0,
				}
			};
			return (STATE_TYPE)&z;
		}
	case 4: /* OP_VAR */
		{
			static struct burm_state z = { 4, 0, 0,
				{	0,
					32767,
					32767,
					32767,
				},{
					0,
					0,
					0,
				}
			};
			return (STATE_TYPE)&z;
		}
	case 5: /* OP_ZERO */
		{
			static struct burm_state z = { 5, 0, 0,
				{	0,
					32767,
					32767,
					32767,
				},{
					0,
					0,
					0,
				}
			};
			return (STATE_TYPE)&z;
		}
	case 6: /* OP_ONE */
		{
			static struct burm_state z = { 6, 0, 0,
				{	0,
					32767,
					32767,
					32767,
				},{
					0,
					0,
					0,
				}
			};
			return (STATE_TYPE)&z;
		}
	case 7: /* OP_MULT */
		assert(l && r);
		{	/* const: OP_MULT(const,const) */
			c = l->cost[burm_const_NT] + r->cost[burm_const_NT] + 0;
			if (c + 0 < p->cost[burm_const_NT]) {
				p->cost[burm_const_NT] = c + 0;
				p->rule.burm_const = 4;
				burm_closure_const(p, c + 0);
			}
		}
		break;
	case 8: /* OP_HASH */
		assert(l && r);
		{	/* const: OP_HASH(const,const) */
			c = l->cost[burm_const_NT] + r->cost[burm_const_NT] + 0;
			if (c + 0 < p->cost[burm_const_NT]) {
				p->cost[burm_const_NT] = c + 0;
				p->rule.burm_const = 8;
				burm_closure_const(p, c + 0);
			}
		}
		break;
	case 9: /* OP_LTEQ */
		assert(l && r);
		{	/* const: OP_LTEQ(const,const) */
			c = l->cost[burm_const_NT] + r->cost[burm_const_NT] + 0;
			if (c + 0 < p->cost[burm_const_NT]) {
				p->cost[burm_const_NT] = c + 0;
				p->rule.burm_const = 7;
				burm_closure_const(p, c + 0);
			}
		}
		break;
	case 10: /* OP_AND */
		assert(l && r);
		{	/* const: OP_AND(const,const) */
			c = l->cost[burm_const_NT] + r->cost[burm_const_NT] + 0;
			if (c + 0 < p->cost[burm_const_NT]) {
				p->cost[burm_const_NT] = c + 0;
				p->rule.burm_const = 5;
				burm_closure_const(p, c + 0);
			}
		}
		break;
	case 11: /* OP_NOT */
		assert(l);
		{	/* const: OP_NOT(const) */
			c = l->cost[burm_const_NT] + 0;
			if (c + 0 < p->cost[burm_const_NT]) {
				p->cost[burm_const_NT] = c + 0;
				p->rule.burm_const = 6;
				burm_closure_const(p, c + 0);
			}
		}
		break;
	default:
		burm_assert(0, PANIC("Bad operator %d in burm_state\n", op));
	}
	return (STATE_TYPE)p;
}

#ifdef STATE_LABEL
static void burm_label1(NODEPTR_TYPE p) {
	burm_assert(p, PANIC("NULL tree in burm_label\n"));
	switch (burm_arity[OP_LABEL(p)]) {
	case 0:
		STATE_LABEL(p) = burm_state(OP_LABEL(p), 0, 0);
		break;
	case 1:
		burm_label1(LEFT_CHILD(p));
		STATE_LABEL(p) = burm_state(OP_LABEL(p),
			STATE_LABEL(LEFT_CHILD(p)), 0);
		break;
	case 2:
		burm_label1(LEFT_CHILD(p));
		burm_label1(RIGHT_CHILD(p));
		STATE_LABEL(p) = burm_state(OP_LABEL(p),
			STATE_LABEL(LEFT_CHILD(p)),
			STATE_LABEL(RIGHT_CHILD(p)));
		break;
	}
}

STATE_TYPE burm_label(NODEPTR_TYPE p) {
	burm_label1(p);
	return ((struct burm_state *)STATE_LABEL(p))->rule.burm_expr ? STATE_LABEL(p) : 0;
}

NODEPTR_TYPE *burm_kids(NODEPTR_TYPE p, int eruleno, NODEPTR_TYPE kids[]) {
	burm_assert(p, PANIC("NULL tree in burm_kids\n"));
	burm_assert(kids, PANIC("NULL kids in burm_kids\n"));
	switch (eruleno) {
	case 2: /* expr: varexpr */
	case 1: /* expr: const */
		kids[0] = p;
		break;
	case 11: /* varexpr: OP_PLUS(OP_VAR,OP_VAR) */
	case 3: /* const: OP_NUM */
		break;
	case 10: /* const: OP_HASH(const,const) */
	case 9: /* const: OP_LTEQ(const,const) */
	case 7: /* const: OP_AND(const,const) */
	case 6: /* const: OP_MULT(const,const) */
	case 4: /* const: OP_PLUS(const,const) */
		kids[0] = LEFT_CHILD(p);
		kids[1] = RIGHT_CHILD(p);
		break;
	case 8: /* const: OP_NOT(const) */
	case 5: /* const: OP_MINUS(const) */
		kids[0] = LEFT_CHILD(p);
		break;
	default:
		burm_assert(0, PANIC("Bad external rule number %d in burm_kids\n", eruleno));
	}
	return kids;
}

int burm_op_label(NODEPTR_TYPE p) {
	burm_assert(p, PANIC("NULL tree in burm_op_label\n"));
	return OP_LABEL(p);
}

STATE_TYPE burm_state_label(NODEPTR_TYPE p) {
	burm_assert(p, PANIC("NULL tree in burm_state_label\n"));
	return STATE_LABEL(p);
}

NODEPTR_TYPE burm_child(NODEPTR_TYPE p, int index) {
	burm_assert(p, PANIC("NULL tree in burm_child\n"));
	switch (index) {
	case 0:	return LEFT_CHILD(p);
	case 1:	return RIGHT_CHILD(p);
	}
	burm_assert(0, PANIC("Bad index %d in burm_child\n", index));
	return 0;
}

#endif


void burm_reduce(NODEPTR_TYPE bnode, int goalnt)
{
  int ruleNo = burm_rule (STATE_LABEL(bnode), goalnt);
  short *nts = burm_nts[ruleNo];
  NODEPTR_TYPE kids[100];
  int i;

  if (ruleNo==0) {
    fprintf(stderr, "tree cannot be derived from start symbol");
    exit(1);
  }
  burm_kids (bnode, ruleNo, kids);
  for (i = 0; nts[i]; i++)
    burm_reduce (kids[i], nts[i]);    /* reduce kids */

#if DEBUG
  printf ("%s", burm_string[ruleNo]);  /* display rule */
#endif

  switch (ruleNo) {
  case 1:
   printf("\tMOVQ $%d, %%rax\n", bnode->value);
    break;
  case 2:
   printf("\tMOVQ %%rsi, %%rax\n");
    break;
  case 3:
 
    break;
  case 4:
   bnode->value = L(bnode)->value + R(bnode)->value; 
    break;
  case 5:
   bnode->value = -(L(bnode)->value);
    break;
  case 6:
   bnode->value = L(bnode)->value * R(bnode)->value;
    break;
  case 7:
   bnode->value = L(bnode)->value & R(bnode)->value;
    break;
  case 8:
   bnode->value = ~(L(bnode)->value);
    break;
  case 9:
   bnode->value = (L(bnode)->value <= R(bnode)->value) ? -1 : 0; 
    break;
  case 10:
   bnode->value = (L(bnode)->value != R(bnode)->value) ? -1 : 0;
    break;
  case 11:
 add(L(bnode), R(bnode));
    break;
  default:    assert (0);
  }
}