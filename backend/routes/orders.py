from fastapi import APIRouter, Depends, HTTPException
from sqlalchemy.orm import Session
from database import get_db
from schemas.order_schema import CheckoutRequest
from crud import order_crud

router = APIRouter()


# POST /orders/checkout — Place order
@router.post("/checkout")
def checkout(data: CheckoutRequest, db: Session = Depends(get_db)):
    order, error = order_crud.checkout(db, data)
    if error:
        raise HTTPException(status_code=400, detail=error)

    # Get full order with items to return to Flutter
    result = order_crud.get_order_with_items(db, order.id)
    return result