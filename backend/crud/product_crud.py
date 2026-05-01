from sqlalchemy.orm import Session
from models.product import Product
from models.user import User
from schemas.product_schema import ProductCreate, ProductUpdate


def _to_response(db: Session, p: Product) -> dict:
    """Convert a Product row into the response dict including vendor_name."""
    vendor_name = None
    if p.vendor_id:
        vendor = db.query(User).filter(User.id == p.vendor_id).first()
        if vendor:
            vendor_name = vendor.name
    return {
        "id": p.id,
        "name": p.name,
        "description": p.description,
        "price": p.price,
        "stock": p.stock,
        "category": p.category,
        "image_url": p.image_url,
        "vendor_id": p.vendor_id,
        "vendor_name": vendor_name,
    }


def get_all_products(db: Session):
    products = db.query(Product).all()
    return [_to_response(db, p) for p in products]


def get_product_by_id(db: Session, product_id: int):
    p = db.query(Product).filter(Product.id == product_id).first()
    if not p:
        return None
    return _to_response(db, p)


def create_product(db: Session, product: ProductCreate):
    db_product = Product(
        name=product.name,
        description=product.description,
        price=product.price,
        stock=product.stock,
        category=product.category,
        image_url=product.image_url,
        vendor_id=product.vendor_id,           # 🆕 NEW
    )
    db.add(db_product)
    db.commit()
    db.refresh(db_product)
    return _to_response(db, db_product)


def update_product(db: Session, product_id: int, product: ProductUpdate):
    db_product = db.query(Product).filter(Product.id == product_id).first()
    if not db_product:
        return None
    update_data = product.model_dump(exclude_unset=True)
    for key, value in update_data.items():
        setattr(db_product, key, value)
    db.commit()
    db.refresh(db_product)
    return _to_response(db, db_product)


def delete_product(db: Session, product_id: int):
    db_product = db.query(Product).filter(Product.id == product_id).first()
    if not db_product:
        return False
    db.delete(db_product)
    db.commit()
    return True