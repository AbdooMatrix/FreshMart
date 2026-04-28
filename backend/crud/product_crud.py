from sqlalchemy.orm import Session
from models.product import Product
from schemas.product_schema import ProductCreate, ProductUpdate


def get_all_products(db: Session):
    """Get every product from the database"""
    return db.query(Product).all()


def get_product_by_id(db: Session, product_id: int):
    """Get one product by its ID — returns None if not found"""
    return db.query(Product).filter(Product.id == product_id).first()


def create_product(db: Session, product: ProductCreate):
    """Insert a new product into the database"""
    db_product = Product(
        name=product.name,
        description=product.description,
        price=product.price,
        stock=product.stock,
        category=product.category,
        image_url=product.image_url,
    )
    db.add(db_product)       # Stage the new product
    db.commit()              # Save to database
    db.refresh(db_product)   # Reload to get auto-generated ID
    return db_product


def update_product(db: Session, product_id: int, product: ProductUpdate):
    """Update an existing product — only changes fields that were sent"""
    db_product = db.query(Product).filter(Product.id == product_id).first()
    if not db_product:
        return None

    # model_dump(exclude_unset=True) gives only the fields the user sent
    update_data = product.model_dump(exclude_unset=True)
    for key, value in update_data.items():
        setattr(db_product, key, value)

    db.commit()
    db.refresh(db_product)
    return db_product


def delete_product(db: Session, product_id: int):
    """Delete a product by ID — returns True/False"""
    db_product = db.query(Product).filter(Product.id == product_id).first()
    if not db_product:
        return False
    db.delete(db_product)
    db.commit()
    return True