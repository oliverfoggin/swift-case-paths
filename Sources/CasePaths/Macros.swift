#if swift(>=5.9)
  /// Defines and implements conformance of the CasePathable protocol.
  ///
  /// This macro conforms the type to the ``CasePathable`` protocol and adds ``CaseKeyPath`` support
  /// for all its cases.
  ///
  /// For example, the following code applies the `CasePathable` macro to the type `UserAction`:
  ///
  /// ```swift
  /// @CasePathable
  /// enum UserAction {
  ///   case home(HomeAction)
  ///   case settings(SettingsAction)
  /// }
  /// ```
  ///
  /// This macro application extends the type with the ability to derive a `case key paths from each
  /// of its cases using a familiar key path expression:
  ///
  /// ```swift
  /// // Case key paths can be inferred using the same name as the case:
  /// _: CaseKeyPath<UserAction, HomeAction> = \.home
  /// _: CaseKeyPath<UserAction, SettingsAction> = \.settings
  ///
  /// // Or they can be fully qualified under the type's `Cases`:
  /// \UserAction.Cases.home      // CasePath<UserAction, HomeAction>
  /// \UserAction.Cases.settings  // CasePath<UserAction, SettingsAction>
  /// ```
  ///
  /// - Parameter withGetters: Whether or not the macro should define a getter property for every
  ///   case.
  @attached(extension, conformances: CasePathable)
  @attached(member, names: arbitrary)
  public macro CasePathable(withGetters: Bool = true) = #externalMacro(
    module: "CasePathsMacros", type: "CasePathableMacro"
  )
#endif

@CasePathable enum Foo: Equatable {
  case bar(Bar)
  case baz(Baz)
  case fizzBuzz
  case blob(Blob)
}
@CasePathable enum Bar: Equatable {
  case int(Int)
}
@CasePathable enum Baz: Equatable {
  case string(String)
}
@CasePathable enum Blob: Equatable {
}
