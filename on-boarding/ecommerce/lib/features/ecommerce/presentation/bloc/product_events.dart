abstract class ProductEvent {
  const ProductEvent();
}

class LoadAllProductsEvent extends ProductEvent {
  const LoadAllProductsEvent();
}

class GetSingleProductEvent extends ProductEvent {
  final String productId;
  const GetSingleProductEvent(this.productId);
}

class UpdateProductEvent extends ProductEvent {
  final Map<String, dynamic> updateData;
  const UpdateProductEvent(this.updateData);
}

class DeleteProductEvent extends ProductEvent {
  final String productId;
  const DeleteProductEvent(this.productId);
}

class CreateProductEvent extends ProductEvent {
  final Map<String, dynamic> productData;
  const CreateProductEvent(this.productData);
}
