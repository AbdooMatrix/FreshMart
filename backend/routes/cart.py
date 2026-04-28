from fastapi import APIRouter, Depends, HTTPException
from sqlalchemy.orm import Session
from database import get_db
from schemas.cart_schema import CartAdd, CartUpdate
from crud import cart_crud

router = APIRouter()


# GET /cart/1 — Get cart for user with ID 1
@router.get("/{user_id}")
def get_cart(user_id: int, db: Session = Depends(get_db)):
    items = cart_crud.get_cart_items(db, user_id)
    total = sum(item["subtotal"] for item in items)
    return {
        "user_id": user_id,
        "items": items,
        "total": round(total, 2)
    }


# POST /cart/add — Add product to cart
@router.post("/add")
def add_to_cart(data: CartAdd, db: Session = Depends(get_db)):
    item = cart_crud.add_to_cart(db, data)
    return {"message": "Item added to cart", "cart_item_id": item.id}


# PUT /cart/update — Change quantity of cart item
@router.put("/update")
def update_cart(data: CartUpdate, db: Session = Depends(get_db)):
    item = cart_crud.update_cart_item(db, data)
    if not item:
        raise HTTPException(status_code=404, detail="Cart item not found")
    return {
        "message": "Cart updated",
        "cart_item_id": item.id,
        "new_quantity": item.quantity
    }


# DELETE /cart/remove/3 — Remove cart item with ID 3
@router.delete("/remove/{item_id}")
def remove_from_cart(item_id: int, db: Session = Depends(get_db)):
    success = cart_crud.remove_cart_item(db, item_id)
    if not success:
        raise HTTPException(status_code=404, detail="Cart item not found")
    return {"message": "Item removed from cart"}